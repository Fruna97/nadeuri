import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/data/service/model/token/token_api_model.dart';

class TokenInterceptor extends Interceptor {
  final String _logTag = "TokenInterceptor";

  final FlutterSecureStorage _flutterSecureStorage;
  final Dio _dioWithoutTokenInterceptor; // 토큰 재발급 및 요청 재시도 시 onError 무한 루프 방지를 위한 Dio

  Completer<void>? _refreshCompleter; // 동시성 제어를 위한 Completer

  TokenInterceptor({required FlutterSecureStorage flutterSecureStorage, required Dio dioWithoutTokenInterceptor})
    : _flutterSecureStorage = flutterSecureStorage,
      _dioWithoutTokenInterceptor = dioWithoutTokenInterceptor {
    _dioWithoutTokenInterceptor.interceptors.add(
      InterceptorsWrapper(onError: (error, handler) => handler.reject(error)),
    );
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 다른 요청이 토큰 재발급 중이면 await
    if (_refreshCompleter != null) {
      log("토큰 재발급 대기중", name: _logTag);
      try {
        await _refreshCompleter!.future.timeout(Duration(seconds: 10));
      } on DioException catch (e) {
        _refreshCompleter = null;
        return handler.reject(e);
      } catch (e) {
        _refreshCompleter = null;
        return handler.reject(DioException(requestOptions: options, error: e));
      }
    }

    // 토큰 재발급 중이 아니거나, 토큰 재발급이 완료되면 헤더에 토큰을 등록
    final String? accessToken = await _flutterSecureStorage.read(key: "access_token");
    if (accessToken == null) {
      log("AccessToken 로컬 저장소 조회 실패", name: _logTag);
      return handler.reject(
        DioException(
          requestOptions: options,
          error: LocalError.tokenNotFound(tokenType: TokenType.access),
        ),
      );
    }
    options.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
    log("헤더에 인증 정보(AccessToken)를 포함했습니다.", name: _logTag);
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final int? statusCode = err.response?.statusCode;
    final RequestOptions options = err.requestOptions;

    if (statusCode != HttpStatus.unauthorized) {
      return handler.reject(err);
    }

    // 다른 요청이 토큰 재발급 중이면 await
    if (_refreshCompleter != null) {
      log("토큰 재발급 대기중", name: _logTag);
      try {
        await _refreshCompleter!.future.timeout(Duration(seconds: 10));
      } on DioException catch (e) {
        _refreshCompleter = null;
        return handler.reject(e);
      } catch (e) {
        _refreshCompleter = null;
        return handler.reject(DioException(requestOptions: options, error: e));
      }
      return await _retryRequest(handler, options); // 토큰 재발급 완료 시 요청 재전송
    }

    // 토큰 재발급 중이 아니라면, 직접 재발급
    //
    // 이슈 (GitHub Issue #9)
    // handler.reject 이후에 try-catch로 예외처리를 했음에도, Unhandled Exception 발생
    // 디버깅 모드에서 Uncaught Exception으로 분류되어 멈춤
    // TODO: Dio 6.0.0 출시 후 확인 필요
    _refreshCompleter = Completer<void>();
    log("토큰 재발급 시도", name: _logTag);
    try {
      await _reissueAndSaveToken();
      _completeAndResetCompleter(); // 토큰 재발급 완료 시 await 중인 다른 요청들을 깨움
    } on DioException catch (e) {
      // Unauthorized 응답 시 기기의 토큰 삭제
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        _flutterSecureStorage.delete(key: "access_token");
        _flutterSecureStorage.delete(key: "refresh_token");
        log("토큰 삭제 완료: Unauthorized", name: _logTag);
      }

      _completeErrorAndResetCompleter(e);
      return handler.reject(e);
    } catch (e) {
      _completeErrorAndResetCompleter(e);
      return handler.reject(DioException(requestOptions: options, error: e));
    }

    log("요청 재시도", name: _logTag);
    await _retryRequest(handler, options); // 토큰 재발급 완료 시 요청 재전송
  }

  Future<void> _retryRequest(ErrorInterceptorHandler handler, RequestOptions options) async {
    final String? accessToken = await _flutterSecureStorage.read(key: "access_token");
    if (accessToken == null) {
      log("요청 재시도 실패: AccessToken 로컬 저장소 조회 실패", name: _logTag);
      return handler.reject(
        DioException(
          requestOptions: options,
          error: LocalError.tokenNotFound(tokenType: TokenType.access),
        ),
      );
    }

    try {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
      final Response response = await _dioWithoutTokenInterceptor.fetch(options);
      log("요청 재시도 성공", name: _logTag);
      return handler.resolve(response);
    } on DioException catch (e) {
      log("요청 재시도 실패: DioException 발생", name: _logTag);
      return handler.reject(e);
    } catch (e) {
      log("요청 재시도 실패: Unprocessed Error $e", name: _logTag);
      return handler.reject(DioException(requestOptions: options, error: ApiError.unknownError()));
    }
  }

  /// 토큰을 재발급 및 저장.
  ///
  /// 실패하면 상황에 맞는 Exception을 throw.
  Future<void> _reissueAndSaveToken() async {
    final String? refreshToken = await _flutterSecureStorage.read(key: "refresh_token");
    if (refreshToken == null) {
      log("토큰 재발급 실패: RefreshToken 로컬 저장소 조회 실패", name: _logTag);
      throw LocalError.tokenNotFound(tokenType: TokenType.refresh);
    }

    final String reissueEndpoint = "/member/reissue-token";
    try {
      final Response response = await _dioWithoutTokenInterceptor.post(
        reissueEndpoint,
        options: Options(headers: {HttpHeaders.authorizationHeader: "Bearer $refreshToken"}),
      );
      log("토큰 재발급 성공", name: _logTag);
      final dynamic body = response.data;
      final Map<String, dynamic> data = body["data"];
      final TokenApiModel tokenApiModel = TokenApiModel.fromJson(data);
      await _flutterSecureStorage.write(key: "access_token", value: tokenApiModel.accessToken);
      await _flutterSecureStorage.write(key: "refresh_token", value: tokenApiModel.refreshToken);
      log("저장소 토큰 업데이트 성공", name: _logTag);
    } on DioException {
      log("토큰 재발급 실패: DioException 발생", name: _logTag);
      rethrow;
    } catch (e) {
      log("토큰 재발급 실패: Unprocessed Error $e", name: _logTag);
      throw ApiError.unknownError();
    }
  }

  void _completeAndResetCompleter() {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      _refreshCompleter!.complete();
    }
    _refreshCompleter = null;
  }

  void _completeErrorAndResetCompleter(Object e) {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      _refreshCompleter!.completeError(e);
    }
    _refreshCompleter = null;
  }
}
