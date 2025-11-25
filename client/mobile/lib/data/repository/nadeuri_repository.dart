import 'dart:developer';

import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/data/service/model/nadeuri/nadeuri_api_model.dart';
import 'package:mobile/domain/model/nadeuri/nadeuri.dart';
import 'package:mobile/utils/result.dart';

class NadeuriRepository {
  final String _logTag = "NadeuriRepository";

  final ApiClient _apiClient;

  NadeuriRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<Nadeuri>> createNadeuri(Nadeuri nadeuri) async {
    NadeuriApiModel nadeuriApiModel = NadeuriApiModel.fromNadeuri(nadeuri);
    Result<NadeuriApiModel> result = await _apiClient.postNadeuri(nadeuriApiModel);

    switch (result) {
      case Ok<NadeuriApiModel> _:
        log("Result is Ok: ${result.value}", name: _logTag);
        return Result.ok(result.value.toNadeuri());
      case Error<NadeuriApiModel> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case ValidationError _:
            log("Result is ValidationError: $error", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
        }
        return Result.error(error);
    }
  }

  Future<Result<Nadeuri>> getNadeuri(String uuid) async {
    Result<NadeuriApiModel> result = await _apiClient.getNadeuri(uuid);

    switch (result) {
      case Ok<NadeuriApiModel> _:
        log("Result is Ok: ${result.value}", name: _logTag);
        return Result.ok(result.value.toNadeuri());
      case Error<NadeuriApiModel> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
          case TokenNotFound _:
            log("Result is TokenNotFound", name: _logTag);
        }

        return Result.error(error);
    }
  }

  Future<Result<List<Nadeuri>>> getParticipatingNadeuris() async {
    Result<List<NadeuriApiModel>> result = await _apiClient.getParticipatingNadeuris();

    switch (result) {
      case Ok<List<NadeuriApiModel>> _:
        List<Nadeuri> participatingNadeuris = result.value
            .map((nadeuriApiModel) => nadeuriApiModel.toNadeuri())
            .toList();
        log("Result is Ok: $participatingNadeuris", name: _logTag);
        return Result.ok(participatingNadeuris);
      case Error<List<NadeuriApiModel>> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
          case TokenNotFound _:
            log("Result is TokenNotFound", name: _logTag);
        }

        return Result.error(error);
    }
  }
}
