import 'dart:developer';

import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/data/service/model/nadeuri/nadeuri_api_model.dart';
import 'package:mobile/domain/model/nadeuri.dart';
import 'package:mobile/utils/result.dart';

class NadeuriRepository {
  final String _logTag = "NadeuriRepository";

  final ApiClient _apiClient;

  NadeuriRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<Nadeuri>>> getParticipatingNadeuris() async {
    Result<List<NadeuriApiModel>> result = await _apiClient.getParticipatingNadeuris();
  
    switch (result) {
      case Ok<List<NadeuriApiModel>> _:
        List<NadeuriApiModel> value = result.value;
        List<Nadeuri> nadeuris = value.map((nadeuriApiModel) => Nadeuri(title: nadeuriApiModel.title)).toList();
        
        return Result.ok(nadeuris);
      case Error<List<NadeuriApiModel>> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is UnAuthorized", name: _logTag);
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
