// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThemeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ThemeEvent()';
}


}

/// @nodoc
class $ThemeEventCopyWith<$Res>  {
$ThemeEventCopyWith(ThemeEvent _, $Res Function(ThemeEvent) __);
}



/// @nodoc


class ThemeStarted implements ThemeEvent {
  const ThemeStarted(this.systemThemeMode);
  

 final  AppThemeMode systemThemeMode;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeStartedCopyWith<ThemeStarted> get copyWith => _$ThemeStartedCopyWithImpl<ThemeStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeStarted&&(identical(other.systemThemeMode, systemThemeMode) || other.systemThemeMode == systemThemeMode));
}


@override
int get hashCode => Object.hash(runtimeType,systemThemeMode);

@override
String toString() {
  return 'ThemeEvent.started(systemThemeMode: $systemThemeMode)';
}


}

/// @nodoc
abstract mixin class $ThemeStartedCopyWith<$Res> implements $ThemeEventCopyWith<$Res> {
  factory $ThemeStartedCopyWith(ThemeStarted value, $Res Function(ThemeStarted) _then) = _$ThemeStartedCopyWithImpl;
@useResult
$Res call({
 AppThemeMode systemThemeMode
});




}
/// @nodoc
class _$ThemeStartedCopyWithImpl<$Res>
    implements $ThemeStartedCopyWith<$Res> {
  _$ThemeStartedCopyWithImpl(this._self, this._then);

  final ThemeStarted _self;
  final $Res Function(ThemeStarted) _then;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? systemThemeMode = null,}) {
  return _then(ThemeStarted(
null == systemThemeMode ? _self.systemThemeMode : systemThemeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,
  ));
}


}

/// @nodoc


class ThemeModeChanged implements ThemeEvent {
  const ThemeModeChanged(this.mode);
  

 final  AppThemeMode mode;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeModeChangedCopyWith<ThemeModeChanged> get copyWith => _$ThemeModeChangedCopyWithImpl<ThemeModeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeModeChanged&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'ThemeEvent.modeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ThemeModeChangedCopyWith<$Res> implements $ThemeEventCopyWith<$Res> {
  factory $ThemeModeChangedCopyWith(ThemeModeChanged value, $Res Function(ThemeModeChanged) _then) = _$ThemeModeChangedCopyWithImpl;
@useResult
$Res call({
 AppThemeMode mode
});




}
/// @nodoc
class _$ThemeModeChangedCopyWithImpl<$Res>
    implements $ThemeModeChangedCopyWith<$Res> {
  _$ThemeModeChangedCopyWithImpl(this._self, this._then);

  final ThemeModeChanged _self;
  final $Res Function(ThemeModeChanged) _then;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(ThemeModeChanged(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,
  ));
}


}

/// @nodoc


class ThemeSystemRefreshed implements ThemeEvent {
  const ThemeSystemRefreshed(this.systemThemeMode);
  

 final  AppThemeMode systemThemeMode;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeSystemRefreshedCopyWith<ThemeSystemRefreshed> get copyWith => _$ThemeSystemRefreshedCopyWithImpl<ThemeSystemRefreshed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeSystemRefreshed&&(identical(other.systemThemeMode, systemThemeMode) || other.systemThemeMode == systemThemeMode));
}


@override
int get hashCode => Object.hash(runtimeType,systemThemeMode);

@override
String toString() {
  return 'ThemeEvent.systemRefreshed(systemThemeMode: $systemThemeMode)';
}


}

/// @nodoc
abstract mixin class $ThemeSystemRefreshedCopyWith<$Res> implements $ThemeEventCopyWith<$Res> {
  factory $ThemeSystemRefreshedCopyWith(ThemeSystemRefreshed value, $Res Function(ThemeSystemRefreshed) _then) = _$ThemeSystemRefreshedCopyWithImpl;
@useResult
$Res call({
 AppThemeMode systemThemeMode
});




}
/// @nodoc
class _$ThemeSystemRefreshedCopyWithImpl<$Res>
    implements $ThemeSystemRefreshedCopyWith<$Res> {
  _$ThemeSystemRefreshedCopyWithImpl(this._self, this._then);

  final ThemeSystemRefreshed _self;
  final $Res Function(ThemeSystemRefreshed) _then;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? systemThemeMode = null,}) {
  return _then(ThemeSystemRefreshed(
null == systemThemeMode ? _self.systemThemeMode : systemThemeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,
  ));
}


}

/// @nodoc
mixin _$ThemeState {

 AppThemeMode? get themeMode; AppThemeMode? get systemThemeMode; AppThemeMode? get appliedThemeMode; StateStatus get status; String? get errorMessage;
/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeStateCopyWith<ThemeState> get copyWith => _$ThemeStateCopyWithImpl<ThemeState>(this as ThemeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.systemThemeMode, systemThemeMode) || other.systemThemeMode == systemThemeMode)&&(identical(other.appliedThemeMode, appliedThemeMode) || other.appliedThemeMode == appliedThemeMode)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,systemThemeMode,appliedThemeMode,status,errorMessage);

@override
String toString() {
  return 'ThemeState(themeMode: $themeMode, systemThemeMode: $systemThemeMode, appliedThemeMode: $appliedThemeMode, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ThemeStateCopyWith<$Res>  {
  factory $ThemeStateCopyWith(ThemeState value, $Res Function(ThemeState) _then) = _$ThemeStateCopyWithImpl;
@useResult
$Res call({
 AppThemeMode? themeMode, AppThemeMode? systemThemeMode, AppThemeMode? appliedThemeMode, StateStatus status, String? errorMessage
});




}
/// @nodoc
class _$ThemeStateCopyWithImpl<$Res>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._self, this._then);

  final ThemeState _self;
  final $Res Function(ThemeState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = freezed,Object? systemThemeMode = freezed,Object? appliedThemeMode = freezed,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
themeMode: freezed == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode?,systemThemeMode: freezed == systemThemeMode ? _self.systemThemeMode : systemThemeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode?,appliedThemeMode: freezed == appliedThemeMode ? _self.appliedThemeMode : appliedThemeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ThemeState implements ThemeState {
  const _ThemeState({this.themeMode, this.systemThemeMode, this.appliedThemeMode, this.status = StateStatus.initial, this.errorMessage});
  

@override final  AppThemeMode? themeMode;
@override final  AppThemeMode? systemThemeMode;
@override final  AppThemeMode? appliedThemeMode;
@override@JsonKey() final  StateStatus status;
@override final  String? errorMessage;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeStateCopyWith<_ThemeState> get copyWith => __$ThemeStateCopyWithImpl<_ThemeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.systemThemeMode, systemThemeMode) || other.systemThemeMode == systemThemeMode)&&(identical(other.appliedThemeMode, appliedThemeMode) || other.appliedThemeMode == appliedThemeMode)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,systemThemeMode,appliedThemeMode,status,errorMessage);

@override
String toString() {
  return 'ThemeState(themeMode: $themeMode, systemThemeMode: $systemThemeMode, appliedThemeMode: $appliedThemeMode, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ThemeStateCopyWith<$Res> implements $ThemeStateCopyWith<$Res> {
  factory _$ThemeStateCopyWith(_ThemeState value, $Res Function(_ThemeState) _then) = __$ThemeStateCopyWithImpl;
@override @useResult
$Res call({
 AppThemeMode? themeMode, AppThemeMode? systemThemeMode, AppThemeMode? appliedThemeMode, StateStatus status, String? errorMessage
});




}
/// @nodoc
class __$ThemeStateCopyWithImpl<$Res>
    implements _$ThemeStateCopyWith<$Res> {
  __$ThemeStateCopyWithImpl(this._self, this._then);

  final _ThemeState _self;
  final $Res Function(_ThemeState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = freezed,Object? systemThemeMode = freezed,Object? appliedThemeMode = freezed,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_ThemeState(
themeMode: freezed == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode?,systemThemeMode: freezed == systemThemeMode ? _self.systemThemeMode : systemThemeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode?,appliedThemeMode: freezed == appliedThemeMode ? _self.appliedThemeMode : appliedThemeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
