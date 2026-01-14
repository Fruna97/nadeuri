import 'dart:developer';

import 'package:mobile/data/service/api_client.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/data/service/model/local_error/local_error.dart';
import 'package:mobile/data/service/model/nadeuri/nadeuri_api_model.dart';
import 'package:mobile/data/service/model/nadeuri/update_nadeuri_api_model.dart';
import 'package:mobile/data/service/model/plan/plan_api_model.dart';
import 'package:mobile/data/service/model/plan/update_plan_api_model.dart';
import 'package:mobile/domain/model/nadeuri/nadeuri.dart';
import 'package:mobile/domain/model/plan/plan.dart';
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
          case TokenNotFound _:
            log("Result is TokenNotFound", name: _logTag);
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
          case NotFound _:
            log("Result is NotFound: $error", name: _logTag);
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

  Future<Result<Nadeuri>> updateNadeuri(String uuid, String title) async {
    Result<NadeuriApiModel> result = await _apiClient.putNadeuri(uuid, UpdateNadeuriApiModel(title: title));

    switch (result) {
      case Ok<NadeuriApiModel> _:
        log("Result is Ok: ${result.value}", name: _logTag);
        return Result.ok(result.value.toNadeuri());
      case Error<NadeuriApiModel> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case NotFound _:
            log("Result is NotFound: $error", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case ValidationError _:
            log("Result is ValidationError: $error", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
          case TokenNotFound _:
            log("Result is TokenNotFound", name: _logTag);
        }
        return Result.error(error);
    }
  }

  Future<Result<Plan>> createPlan(Plan plan) async {
    Result<PlanApiModel> result = await _apiClient.postPlan(plan.nadeuriUuid, PlanApiModel.fromPlan(plan));

    switch (result) {
      case Ok<PlanApiModel> _:
        log("Result is Ok: ${result.value}", name: _logTag);
        return Result.ok(result.value.toPlan());
      case Error<PlanApiModel> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case NotFound _:
            log("Result is NotFound: $error", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case ValidationError _:
            log("Result is ValidationError: $error", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
          case TokenNotFound _:
            log("Result is TokenNotFound", name: _logTag);
        }
        return Result.error(error);
    }
  }

  Future<Result<Plan>> updatePlan(Plan plan) async {
    Result<PlanApiModel> result = await _apiClient.putPlan(
      plan.nadeuriUuid,
      plan.uuid!,
      UpdatePlanApiModel.fromPlan(plan),
    );

    switch (result) {
      case Ok<PlanApiModel> _:
        log("Result is Ok: ${result.value}", name: _logTag);
        return Result.ok(result.value.toPlan());
      case Error<PlanApiModel> _:
        Exception error = result.error;
        switch (error) {
          case Unauthorized _:
            log("Result is Unauthorized", name: _logTag);
          case NotFound _:
            log("Result is NotFound: $error", name: _logTag);
          case RequestTimeout _:
            log("Result is RequestTimeout", name: _logTag);
          case ValidationError _:
            log("Result is ValidationError: $error", name: _logTag);
          case UnknownError _:
            log("Result is UnknownError", name: _logTag);
          case TokenNotFound _:
            log("Result is TokenNotFound", name: _logTag);
        }
        return Result.error(error);
    }
  }
}
