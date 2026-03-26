// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocaleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocaleEvent()';
}


}

/// @nodoc
class $LocaleEventCopyWith<$Res>  {
$LocaleEventCopyWith(LocaleEvent _, $Res Function(LocaleEvent) __);
}



/// @nodoc


class LocaleStarted implements LocaleEvent {
  const LocaleStarted({required this.deviceLanguageCode});
  

 final  String deviceLanguageCode;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocaleStartedCopyWith<LocaleStarted> get copyWith => _$LocaleStartedCopyWithImpl<LocaleStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleStarted&&(identical(other.deviceLanguageCode, deviceLanguageCode) || other.deviceLanguageCode == deviceLanguageCode));
}


@override
int get hashCode => Object.hash(runtimeType,deviceLanguageCode);

@override
String toString() {
  return 'LocaleEvent.started(deviceLanguageCode: $deviceLanguageCode)';
}


}

/// @nodoc
abstract mixin class $LocaleStartedCopyWith<$Res> implements $LocaleEventCopyWith<$Res> {
  factory $LocaleStartedCopyWith(LocaleStarted value, $Res Function(LocaleStarted) _then) = _$LocaleStartedCopyWithImpl;
@useResult
$Res call({
 String deviceLanguageCode
});




}
/// @nodoc
class _$LocaleStartedCopyWithImpl<$Res>
    implements $LocaleStartedCopyWith<$Res> {
  _$LocaleStartedCopyWithImpl(this._self, this._then);

  final LocaleStarted _self;
  final $Res Function(LocaleStarted) _then;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? deviceLanguageCode = null,}) {
  return _then(LocaleStarted(
deviceLanguageCode: null == deviceLanguageCode ? _self.deviceLanguageCode : deviceLanguageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LocaleChanged implements LocaleEvent {
  const LocaleChanged(this.languageCode);
  

 final  String languageCode;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocaleChangedCopyWith<LocaleChanged> get copyWith => _$LocaleChangedCopyWithImpl<LocaleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleChanged&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode);

@override
String toString() {
  return 'LocaleEvent.changed(languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $LocaleChangedCopyWith<$Res> implements $LocaleEventCopyWith<$Res> {
  factory $LocaleChangedCopyWith(LocaleChanged value, $Res Function(LocaleChanged) _then) = _$LocaleChangedCopyWithImpl;
@useResult
$Res call({
 String languageCode
});




}
/// @nodoc
class _$LocaleChangedCopyWithImpl<$Res>
    implements $LocaleChangedCopyWith<$Res> {
  _$LocaleChangedCopyWithImpl(this._self, this._then);

  final LocaleChanged _self;
  final $Res Function(LocaleChanged) _then;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? languageCode = null,}) {
  return _then(LocaleChanged(
null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LocaleState {

 String? get languageCode; StateStatus get status; String? get errorMessage;
/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocaleStateCopyWith<LocaleState> get copyWith => _$LocaleStateCopyWithImpl<LocaleState>(this as LocaleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleState&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode,status,errorMessage);

@override
String toString() {
  return 'LocaleState(languageCode: $languageCode, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LocaleStateCopyWith<$Res>  {
  factory $LocaleStateCopyWith(LocaleState value, $Res Function(LocaleState) _then) = _$LocaleStateCopyWithImpl;
@useResult
$Res call({
 String? languageCode, StateStatus status, String? errorMessage
});




}
/// @nodoc
class _$LocaleStateCopyWithImpl<$Res>
    implements $LocaleStateCopyWith<$Res> {
  _$LocaleStateCopyWithImpl(this._self, this._then);

  final LocaleState _self;
  final $Res Function(LocaleState) _then;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = freezed,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _LocaleState implements LocaleState {
  const _LocaleState({this.languageCode, this.status = StateStatus.initial, this.errorMessage});
  

@override final  String? languageCode;
@override@JsonKey() final  StateStatus status;
@override final  String? errorMessage;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocaleStateCopyWith<_LocaleState> get copyWith => __$LocaleStateCopyWithImpl<_LocaleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocaleState&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode,status,errorMessage);

@override
String toString() {
  return 'LocaleState(languageCode: $languageCode, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LocaleStateCopyWith<$Res> implements $LocaleStateCopyWith<$Res> {
  factory _$LocaleStateCopyWith(_LocaleState value, $Res Function(_LocaleState) _then) = __$LocaleStateCopyWithImpl;
@override @useResult
$Res call({
 String? languageCode, StateStatus status, String? errorMessage
});




}
/// @nodoc
class __$LocaleStateCopyWithImpl<$Res>
    implements _$LocaleStateCopyWith<$Res> {
  __$LocaleStateCopyWithImpl(this._self, this._then);

  final _LocaleState _self;
  final $Res Function(_LocaleState) _then;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = freezed,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_LocaleState(
languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
