// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FieldState<T> {

 T get value; FieldStatus get status; String? get error;// present when invalid
 bool get isDirty;// true when the field has been interacted with
 bool get enabled;
/// Create a copy of FieldState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldStateCopyWith<T, FieldState<T>> get copyWith => _$FieldStateCopyWithImpl<T, FieldState<T>>(this as FieldState<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldState<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),status,error,isDirty,enabled);

@override
String toString() {
  return 'FieldState<$T>(value: $value, status: $status, error: $error, isDirty: $isDirty, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $FieldStateCopyWith<T,$Res>  {
  factory $FieldStateCopyWith(FieldState<T> value, $Res Function(FieldState<T>) _then) = _$FieldStateCopyWithImpl;
@useResult
$Res call({
 T value, FieldStatus status, String? error, bool isDirty, bool enabled
});




}
/// @nodoc
class _$FieldStateCopyWithImpl<T,$Res>
    implements $FieldStateCopyWith<T, $Res> {
  _$FieldStateCopyWithImpl(this._self, this._then);

  final FieldState<T> _self;
  final $Res Function(FieldState<T>) _then;

/// Create a copy of FieldState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? status = null,Object? error = freezed,Object? isDirty = null,Object? enabled = null,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _FieldState<T> implements FieldState<T> {
  const _FieldState({required this.value, this.status = FieldStatus.pure, this.error, this.isDirty = false, this.enabled = true});
  

@override final  T value;
@override@JsonKey() final  FieldStatus status;
@override final  String? error;
// present when invalid
@override@JsonKey() final  bool isDirty;
// true when the field has been interacted with
@override@JsonKey() final  bool enabled;

/// Create a copy of FieldState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldStateCopyWith<T, _FieldState<T>> get copyWith => __$FieldStateCopyWithImpl<T, _FieldState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldState<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),status,error,isDirty,enabled);

@override
String toString() {
  return 'FieldState<$T>(value: $value, status: $status, error: $error, isDirty: $isDirty, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$FieldStateCopyWith<T,$Res> implements $FieldStateCopyWith<T, $Res> {
  factory _$FieldStateCopyWith(_FieldState<T> value, $Res Function(_FieldState<T>) _then) = __$FieldStateCopyWithImpl;
@override @useResult
$Res call({
 T value, FieldStatus status, String? error, bool isDirty, bool enabled
});




}
/// @nodoc
class __$FieldStateCopyWithImpl<T,$Res>
    implements _$FieldStateCopyWith<T, $Res> {
  __$FieldStateCopyWithImpl(this._self, this._then);

  final _FieldState<T> _self;
  final $Res Function(_FieldState<T>) _then;

/// Create a copy of FieldState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? status = null,Object? error = freezed,Object? isDirty = null,Object? enabled = null,}) {
  return _then(_FieldState<T>(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldStatus,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
