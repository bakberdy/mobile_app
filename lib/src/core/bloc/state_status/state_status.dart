import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_app/src/core/error/error.dart';
part 'state_status.freezed.dart';

@freezed
sealed class StateStatus with _$StateStatus {
  const factory StateStatus.initial() = InitialStateStatus;
  const factory StateStatus.loading() = LoadingStateStatus;
  const factory StateStatus.success() = SuccessStateStatus;
  const factory StateStatus.error(Failure failure) = ErrorStateStatus;
}

extension StateStatusX on StateStatus {
  bool get isInitial => this is InitialStateStatus;
  bool get isLoading => this is LoadingStateStatus;
  bool get isSuccess => this is SuccessStateStatus;
  bool get isError => this is ErrorStateStatus;
}
