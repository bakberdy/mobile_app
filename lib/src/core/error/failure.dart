import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/src/core/utils/typedef.dart';

part 'failure.freezed.dart';

@freezed
abstract interface class Failure with _$Failure {
  const Failure._();

  const factory Failure.base({
    @Default(FailureType.snackbar) FailureType type,
    String? message,
    DataMap? data,
    required String source,
  }) = BaseFailure;

  const factory Failure.notFound({
    @Default(FailureType.snackbar) FailureType type,
    String? message,
    DataMap? data,
    required String source,
  }) = NotFoundFailure;

  const factory Failure.api({
    @Default(FailureType.snackbar) FailureType type,
    String? message,
    DataMap? data,
    int? statusCode,
    required String source,
  }) = ApiFailure;

  const factory Failure.parse({
    @Default(FailureType.snackbar) FailureType type,
    String? message,
    required String source,
  }) = ParseFailure;
}

enum FailureType {
  //info
  @JsonValue('snackbar')
  snackbar,

  //warning
  @JsonValue('banner')
  banner,
  @JsonValue('inline_error')
  inlineError,

  //critical
  @JsonValue('alert')
  alert,
  @JsonValue('full_screen_error')
  fullScreenError,

  //no need to show
  @JsonValue('silent')
  silent,
}
