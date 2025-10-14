
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_error.freezed.dart';

enum TokenType {access, refresh}

@freezed
abstract class LocalError with _$LocalError implements Exception {
  const factory LocalError.tokenNotFound({
    required TokenType tokenType
  }) = TokenNotFound;
}
