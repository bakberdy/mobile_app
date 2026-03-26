// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 FailureType get type; String? get message; String get source;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,type,message,source);

@override
String toString() {
  return 'Failure(type: $type, message: $message, source: $source)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 FailureType type, String? message, String source
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? message = freezed,Object? source = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailureType,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class BaseFailure extends Failure {
  const BaseFailure({this.type = FailureType.snackbar, this.message, final  DataMap? data, required this.source}): _data = data,super._();
  

@override@JsonKey() final  FailureType type;
@override final  String? message;
 final  DataMap? _data;
 DataMap? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String source;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseFailureCopyWith<BaseFailure> get copyWith => _$BaseFailureCopyWithImpl<BaseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,type,message,const DeepCollectionEquality().hash(_data),source);

@override
String toString() {
  return 'Failure.base(type: $type, message: $message, data: $data, source: $source)';
}


}

/// @nodoc
abstract mixin class $BaseFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $BaseFailureCopyWith(BaseFailure value, $Res Function(BaseFailure) _then) = _$BaseFailureCopyWithImpl;
@override @useResult
$Res call({
 FailureType type, String? message, DataMap? data, String source
});




}
/// @nodoc
class _$BaseFailureCopyWithImpl<$Res>
    implements $BaseFailureCopyWith<$Res> {
  _$BaseFailureCopyWithImpl(this._self, this._then);

  final BaseFailure _self;
  final $Res Function(BaseFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? message = freezed,Object? data = freezed,Object? source = null,}) {
  return _then(BaseFailure(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailureType,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as DataMap?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotFoundFailure extends Failure {
  const NotFoundFailure({this.type = FailureType.snackbar, this.message, final  DataMap? data, required this.source}): _data = data,super._();
  

@override@JsonKey() final  FailureType type;
@override final  String? message;
 final  DataMap? _data;
 DataMap? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String source;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundFailureCopyWith<NotFoundFailure> get copyWith => _$NotFoundFailureCopyWithImpl<NotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,type,message,const DeepCollectionEquality().hash(_data),source);

@override
String toString() {
  return 'Failure.notFound(type: $type, message: $message, data: $data, source: $source)';
}


}

/// @nodoc
abstract mixin class $NotFoundFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NotFoundFailureCopyWith(NotFoundFailure value, $Res Function(NotFoundFailure) _then) = _$NotFoundFailureCopyWithImpl;
@override @useResult
$Res call({
 FailureType type, String? message, DataMap? data, String source
});




}
/// @nodoc
class _$NotFoundFailureCopyWithImpl<$Res>
    implements $NotFoundFailureCopyWith<$Res> {
  _$NotFoundFailureCopyWithImpl(this._self, this._then);

  final NotFoundFailure _self;
  final $Res Function(NotFoundFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? message = freezed,Object? data = freezed,Object? source = null,}) {
  return _then(NotFoundFailure(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailureType,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as DataMap?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ApiFailure extends Failure {
  const ApiFailure({this.type = FailureType.snackbar, this.message, final  DataMap? data, this.statusCode, required this.source}): _data = data,super._();
  

@override@JsonKey() final  FailureType type;
@override final  String? message;
 final  DataMap? _data;
 DataMap? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  int? statusCode;
@override final  String source;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiFailureCopyWith<ApiFailure> get copyWith => _$ApiFailureCopyWithImpl<ApiFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,type,message,const DeepCollectionEquality().hash(_data),statusCode,source);

@override
String toString() {
  return 'Failure.api(type: $type, message: $message, data: $data, statusCode: $statusCode, source: $source)';
}


}

/// @nodoc
abstract mixin class $ApiFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ApiFailureCopyWith(ApiFailure value, $Res Function(ApiFailure) _then) = _$ApiFailureCopyWithImpl;
@override @useResult
$Res call({
 FailureType type, String? message, DataMap? data, int? statusCode, String source
});




}
/// @nodoc
class _$ApiFailureCopyWithImpl<$Res>
    implements $ApiFailureCopyWith<$Res> {
  _$ApiFailureCopyWithImpl(this._self, this._then);

  final ApiFailure _self;
  final $Res Function(ApiFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? message = freezed,Object? data = freezed,Object? statusCode = freezed,Object? source = null,}) {
  return _then(ApiFailure(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailureType,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as DataMap?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParseFailure extends Failure {
  const ParseFailure({this.type = FailureType.snackbar, this.message, required this.source}): super._();
  

@override@JsonKey() final  FailureType type;
@override final  String? message;
@override final  String source;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseFailureCopyWith<ParseFailure> get copyWith => _$ParseFailureCopyWithImpl<ParseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseFailure&&(identical(other.type, type) || other.type == type)&&(identical(other.message, message) || other.message == message)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,type,message,source);

@override
String toString() {
  return 'Failure.parse(type: $type, message: $message, source: $source)';
}


}

/// @nodoc
abstract mixin class $ParseFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ParseFailureCopyWith(ParseFailure value, $Res Function(ParseFailure) _then) = _$ParseFailureCopyWithImpl;
@override @useResult
$Res call({
 FailureType type, String? message, String source
});




}
/// @nodoc
class _$ParseFailureCopyWithImpl<$Res>
    implements $ParseFailureCopyWith<$Res> {
  _$ParseFailureCopyWithImpl(this._self, this._then);

  final ParseFailure _self;
  final $Res Function(ParseFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? message = freezed,Object? source = null,}) {
  return _then(ParseFailure(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FailureType,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
