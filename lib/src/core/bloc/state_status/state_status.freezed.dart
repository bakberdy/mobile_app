// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StateStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StateStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StateStatus()';
}


}

/// @nodoc
class $StateStatusCopyWith<$Res>  {
$StateStatusCopyWith(StateStatus _, $Res Function(StateStatus) __);
}



/// @nodoc


class InitialStateStatus implements StateStatus {
  const InitialStateStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialStateStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StateStatus.initial()';
}


}




/// @nodoc


class LoadingStateStatus implements StateStatus {
  const LoadingStateStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingStateStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StateStatus.loading()';
}


}




/// @nodoc


class SuccessStateStatus implements StateStatus {
  const SuccessStateStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessStateStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StateStatus.success()';
}


}




/// @nodoc


class ErrorStateStatus implements StateStatus {
  const ErrorStateStatus(this.failure);
  

 final  Failure failure;

/// Create a copy of StateStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorStateStatusCopyWith<ErrorStateStatus> get copyWith => _$ErrorStateStatusCopyWithImpl<ErrorStateStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorStateStatus&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'StateStatus.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ErrorStateStatusCopyWith<$Res> implements $StateStatusCopyWith<$Res> {
  factory $ErrorStateStatusCopyWith(ErrorStateStatus value, $Res Function(ErrorStateStatus) _then) = _$ErrorStateStatusCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ErrorStateStatusCopyWithImpl<$Res>
    implements $ErrorStateStatusCopyWith<$Res> {
  _$ErrorStateStatusCopyWithImpl(this._self, this._then);

  final ErrorStateStatus _self;
  final $Res Function(ErrorStateStatus) _then;

/// Create a copy of StateStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ErrorStateStatus(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of StateStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
