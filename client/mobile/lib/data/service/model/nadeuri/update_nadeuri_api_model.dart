import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_nadeuri_api_model.freezed.dart';
part 'update_nadeuri_api_model.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class UpdateNadeuriApiModel with _$UpdateNadeuriApiModel {
  const factory UpdateNadeuriApiModel({
    required String title
  }) = _UpdateNadeuriApiModel;
}
