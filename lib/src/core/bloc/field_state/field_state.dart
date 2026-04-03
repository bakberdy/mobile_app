import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_state.freezed.dart';

enum FieldStatus { pure, valid, invalid }

@freezed
sealed class FieldState<T> with _$FieldState<T> {
  const factory FieldState({
    required T value,
    @Default(FieldStatus.pure) FieldStatus status,
    String? error, // present when invalid
    @Default(false) bool isDirty, // true when the field has been interacted with
    @Default(true) bool enabled, // true when the field is enabled
  }) = _FieldState<T>;
}

extension FieldStateX<T> on FieldState<T> {
  bool get isValid => status == FieldStatus.valid;
  bool get isInvalid => status == FieldStatus.invalid;
}