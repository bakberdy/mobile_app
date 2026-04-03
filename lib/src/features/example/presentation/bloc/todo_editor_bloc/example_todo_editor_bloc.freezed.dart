// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_todo_editor_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExampleTodoEditorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodoEditorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExampleTodoEditorEvent()';
}


}

/// @nodoc
class $ExampleTodoEditorEventCopyWith<$Res>  {
$ExampleTodoEditorEventCopyWith(ExampleTodoEditorEvent _, $Res Function(ExampleTodoEditorEvent) __);
}



/// @nodoc


class ExampleTodoEditorStarted implements ExampleTodoEditorEvent {
  const ExampleTodoEditorStarted(this.todo);
  

 final  Todo? todo;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodoEditorStartedCopyWith<ExampleTodoEditorStarted> get copyWith => _$ExampleTodoEditorStartedCopyWithImpl<ExampleTodoEditorStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodoEditorStarted&&(identical(other.todo, todo) || other.todo == todo));
}


@override
int get hashCode => Object.hash(runtimeType,todo);

@override
String toString() {
  return 'ExampleTodoEditorEvent.started(todo: $todo)';
}


}

/// @nodoc
abstract mixin class $ExampleTodoEditorStartedCopyWith<$Res> implements $ExampleTodoEditorEventCopyWith<$Res> {
  factory $ExampleTodoEditorStartedCopyWith(ExampleTodoEditorStarted value, $Res Function(ExampleTodoEditorStarted) _then) = _$ExampleTodoEditorStartedCopyWithImpl;
@useResult
$Res call({
 Todo? todo
});




}
/// @nodoc
class _$ExampleTodoEditorStartedCopyWithImpl<$Res>
    implements $ExampleTodoEditorStartedCopyWith<$Res> {
  _$ExampleTodoEditorStartedCopyWithImpl(this._self, this._then);

  final ExampleTodoEditorStarted _self;
  final $Res Function(ExampleTodoEditorStarted) _then;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todo = freezed,}) {
  return _then(ExampleTodoEditorStarted(
freezed == todo ? _self.todo : todo // ignore: cast_nullable_to_non_nullable
as Todo?,
  ));
}


}

/// @nodoc


class ExampleTodoEditorTitleChanged implements ExampleTodoEditorEvent {
  const ExampleTodoEditorTitleChanged(this.value);
  

 final  String value;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodoEditorTitleChangedCopyWith<ExampleTodoEditorTitleChanged> get copyWith => _$ExampleTodoEditorTitleChangedCopyWithImpl<ExampleTodoEditorTitleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodoEditorTitleChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ExampleTodoEditorEvent.titleChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $ExampleTodoEditorTitleChangedCopyWith<$Res> implements $ExampleTodoEditorEventCopyWith<$Res> {
  factory $ExampleTodoEditorTitleChangedCopyWith(ExampleTodoEditorTitleChanged value, $Res Function(ExampleTodoEditorTitleChanged) _then) = _$ExampleTodoEditorTitleChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$ExampleTodoEditorTitleChangedCopyWithImpl<$Res>
    implements $ExampleTodoEditorTitleChangedCopyWith<$Res> {
  _$ExampleTodoEditorTitleChangedCopyWithImpl(this._self, this._then);

  final ExampleTodoEditorTitleChanged _self;
  final $Res Function(ExampleTodoEditorTitleChanged) _then;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(ExampleTodoEditorTitleChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExampleTodoEditorDescriptionChanged implements ExampleTodoEditorEvent {
  const ExampleTodoEditorDescriptionChanged(this.value);
  

 final  String value;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodoEditorDescriptionChangedCopyWith<ExampleTodoEditorDescriptionChanged> get copyWith => _$ExampleTodoEditorDescriptionChangedCopyWithImpl<ExampleTodoEditorDescriptionChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodoEditorDescriptionChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ExampleTodoEditorEvent.descriptionChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $ExampleTodoEditorDescriptionChangedCopyWith<$Res> implements $ExampleTodoEditorEventCopyWith<$Res> {
  factory $ExampleTodoEditorDescriptionChangedCopyWith(ExampleTodoEditorDescriptionChanged value, $Res Function(ExampleTodoEditorDescriptionChanged) _then) = _$ExampleTodoEditorDescriptionChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$ExampleTodoEditorDescriptionChangedCopyWithImpl<$Res>
    implements $ExampleTodoEditorDescriptionChangedCopyWith<$Res> {
  _$ExampleTodoEditorDescriptionChangedCopyWithImpl(this._self, this._then);

  final ExampleTodoEditorDescriptionChanged _self;
  final $Res Function(ExampleTodoEditorDescriptionChanged) _then;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(ExampleTodoEditorDescriptionChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExampleTodoEditorDoneChanged implements ExampleTodoEditorEvent {
  const ExampleTodoEditorDoneChanged(this.value);
  

 final  bool value;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodoEditorDoneChangedCopyWith<ExampleTodoEditorDoneChanged> get copyWith => _$ExampleTodoEditorDoneChangedCopyWithImpl<ExampleTodoEditorDoneChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodoEditorDoneChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ExampleTodoEditorEvent.doneChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $ExampleTodoEditorDoneChangedCopyWith<$Res> implements $ExampleTodoEditorEventCopyWith<$Res> {
  factory $ExampleTodoEditorDoneChangedCopyWith(ExampleTodoEditorDoneChanged value, $Res Function(ExampleTodoEditorDoneChanged) _then) = _$ExampleTodoEditorDoneChangedCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$ExampleTodoEditorDoneChangedCopyWithImpl<$Res>
    implements $ExampleTodoEditorDoneChangedCopyWith<$Res> {
  _$ExampleTodoEditorDoneChangedCopyWithImpl(this._self, this._then);

  final ExampleTodoEditorDoneChanged _self;
  final $Res Function(ExampleTodoEditorDoneChanged) _then;

/// Create a copy of ExampleTodoEditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(ExampleTodoEditorDoneChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ExampleTodoEditorSubmitted implements ExampleTodoEditorEvent {
  const ExampleTodoEditorSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodoEditorSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExampleTodoEditorEvent.submitted()';
}


}




/// @nodoc
mixin _$ExampleTodoEditorState {

 Todo? get todo; DateTime? get createdAt; StateStatus get status; FieldState<String> get titleField; FieldState<String> get descriptionField; FieldState<bool> get isDoneField; int get formVersion;
/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodoEditorStateCopyWith<ExampleTodoEditorState> get copyWith => _$ExampleTodoEditorStateCopyWithImpl<ExampleTodoEditorState>(this as ExampleTodoEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodoEditorState&&(identical(other.todo, todo) || other.todo == todo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.titleField, titleField) || other.titleField == titleField)&&(identical(other.descriptionField, descriptionField) || other.descriptionField == descriptionField)&&(identical(other.isDoneField, isDoneField) || other.isDoneField == isDoneField)&&(identical(other.formVersion, formVersion) || other.formVersion == formVersion));
}


@override
int get hashCode => Object.hash(runtimeType,todo,createdAt,status,titleField,descriptionField,isDoneField,formVersion);

@override
String toString() {
  return 'ExampleTodoEditorState(todo: $todo, createdAt: $createdAt, status: $status, titleField: $titleField, descriptionField: $descriptionField, isDoneField: $isDoneField, formVersion: $formVersion)';
}


}

/// @nodoc
abstract mixin class $ExampleTodoEditorStateCopyWith<$Res>  {
  factory $ExampleTodoEditorStateCopyWith(ExampleTodoEditorState value, $Res Function(ExampleTodoEditorState) _then) = _$ExampleTodoEditorStateCopyWithImpl;
@useResult
$Res call({
 Todo? todo, DateTime? createdAt, StateStatus status, FieldState<String> titleField, FieldState<String> descriptionField, FieldState<bool> isDoneField, int formVersion
});


$StateStatusCopyWith<$Res> get status;$FieldStateCopyWith<String, $Res> get titleField;$FieldStateCopyWith<String, $Res> get descriptionField;$FieldStateCopyWith<bool, $Res> get isDoneField;

}
/// @nodoc
class _$ExampleTodoEditorStateCopyWithImpl<$Res>
    implements $ExampleTodoEditorStateCopyWith<$Res> {
  _$ExampleTodoEditorStateCopyWithImpl(this._self, this._then);

  final ExampleTodoEditorState _self;
  final $Res Function(ExampleTodoEditorState) _then;

/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todo = freezed,Object? createdAt = freezed,Object? status = null,Object? titleField = null,Object? descriptionField = null,Object? isDoneField = null,Object? formVersion = null,}) {
  return _then(_self.copyWith(
todo: freezed == todo ? _self.todo : todo // ignore: cast_nullable_to_non_nullable
as Todo?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,titleField: null == titleField ? _self.titleField : titleField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,descriptionField: null == descriptionField ? _self.descriptionField : descriptionField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,isDoneField: null == isDoneField ? _self.isDoneField : isDoneField // ignore: cast_nullable_to_non_nullable
as FieldState<bool>,formVersion: null == formVersion ? _self.formVersion : formVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get titleField {
  
  return $FieldStateCopyWith<String, $Res>(_self.titleField, (value) {
    return _then(_self.copyWith(titleField: value));
  });
}/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get descriptionField {
  
  return $FieldStateCopyWith<String, $Res>(_self.descriptionField, (value) {
    return _then(_self.copyWith(descriptionField: value));
  });
}/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<bool, $Res> get isDoneField {
  
  return $FieldStateCopyWith<bool, $Res>(_self.isDoneField, (value) {
    return _then(_self.copyWith(isDoneField: value));
  });
}
}



/// @nodoc


class _ExampleTodoEditorState implements ExampleTodoEditorState {
  const _ExampleTodoEditorState({this.todo, this.createdAt, this.status = const StateStatus.initial(), this.titleField = const FieldState(value: ''), this.descriptionField = const FieldState(value: ''), this.isDoneField = const FieldState(value: false), this.formVersion = 0});
  

@override final  Todo? todo;
@override final  DateTime? createdAt;
@override@JsonKey() final  StateStatus status;
@override@JsonKey() final  FieldState<String> titleField;
@override@JsonKey() final  FieldState<String> descriptionField;
@override@JsonKey() final  FieldState<bool> isDoneField;
@override@JsonKey() final  int formVersion;

/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleTodoEditorStateCopyWith<_ExampleTodoEditorState> get copyWith => __$ExampleTodoEditorStateCopyWithImpl<_ExampleTodoEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExampleTodoEditorState&&(identical(other.todo, todo) || other.todo == todo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.titleField, titleField) || other.titleField == titleField)&&(identical(other.descriptionField, descriptionField) || other.descriptionField == descriptionField)&&(identical(other.isDoneField, isDoneField) || other.isDoneField == isDoneField)&&(identical(other.formVersion, formVersion) || other.formVersion == formVersion));
}


@override
int get hashCode => Object.hash(runtimeType,todo,createdAt,status,titleField,descriptionField,isDoneField,formVersion);

@override
String toString() {
  return 'ExampleTodoEditorState(todo: $todo, createdAt: $createdAt, status: $status, titleField: $titleField, descriptionField: $descriptionField, isDoneField: $isDoneField, formVersion: $formVersion)';
}


}

/// @nodoc
abstract mixin class _$ExampleTodoEditorStateCopyWith<$Res> implements $ExampleTodoEditorStateCopyWith<$Res> {
  factory _$ExampleTodoEditorStateCopyWith(_ExampleTodoEditorState value, $Res Function(_ExampleTodoEditorState) _then) = __$ExampleTodoEditorStateCopyWithImpl;
@override @useResult
$Res call({
 Todo? todo, DateTime? createdAt, StateStatus status, FieldState<String> titleField, FieldState<String> descriptionField, FieldState<bool> isDoneField, int formVersion
});


@override $StateStatusCopyWith<$Res> get status;@override $FieldStateCopyWith<String, $Res> get titleField;@override $FieldStateCopyWith<String, $Res> get descriptionField;@override $FieldStateCopyWith<bool, $Res> get isDoneField;

}
/// @nodoc
class __$ExampleTodoEditorStateCopyWithImpl<$Res>
    implements _$ExampleTodoEditorStateCopyWith<$Res> {
  __$ExampleTodoEditorStateCopyWithImpl(this._self, this._then);

  final _ExampleTodoEditorState _self;
  final $Res Function(_ExampleTodoEditorState) _then;

/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todo = freezed,Object? createdAt = freezed,Object? status = null,Object? titleField = null,Object? descriptionField = null,Object? isDoneField = null,Object? formVersion = null,}) {
  return _then(_ExampleTodoEditorState(
todo: freezed == todo ? _self.todo : todo // ignore: cast_nullable_to_non_nullable
as Todo?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,titleField: null == titleField ? _self.titleField : titleField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,descriptionField: null == descriptionField ? _self.descriptionField : descriptionField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,isDoneField: null == isDoneField ? _self.isDoneField : isDoneField // ignore: cast_nullable_to_non_nullable
as FieldState<bool>,formVersion: null == formVersion ? _self.formVersion : formVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get titleField {
  
  return $FieldStateCopyWith<String, $Res>(_self.titleField, (value) {
    return _then(_self.copyWith(titleField: value));
  });
}/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get descriptionField {
  
  return $FieldStateCopyWith<String, $Res>(_self.descriptionField, (value) {
    return _then(_self.copyWith(descriptionField: value));
  });
}/// Create a copy of ExampleTodoEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<bool, $Res> get isDoneField {
  
  return $FieldStateCopyWith<bool, $Res>(_self.isDoneField, (value) {
    return _then(_self.copyWith(isDoneField: value));
  });
}
}

// dart format on
