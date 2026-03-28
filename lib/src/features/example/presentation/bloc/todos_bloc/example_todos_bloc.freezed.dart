// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_todos_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExampleTodosEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExampleTodosEvent()';
}


}

/// @nodoc
class $ExampleTodosEventCopyWith<$Res>  {
$ExampleTodosEventCopyWith(ExampleTodosEvent _, $Res Function(ExampleTodosEvent) __);
}



/// @nodoc


class ExampleTodosStarted implements ExampleTodosEvent {
  const ExampleTodosStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExampleTodosEvent.started()';
}


}




/// @nodoc


class ExampleTodosRefreshed implements ExampleTodosEvent {
  const ExampleTodosRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExampleTodosEvent.refreshed()';
}


}




/// @nodoc


class ExampleTodosTitleChanged implements ExampleTodosEvent {
  const ExampleTodosTitleChanged(this.value);
  

 final  String value;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodosTitleChangedCopyWith<ExampleTodosTitleChanged> get copyWith => _$ExampleTodosTitleChangedCopyWithImpl<ExampleTodosTitleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosTitleChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ExampleTodosEvent.titleChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $ExampleTodosTitleChangedCopyWith<$Res> implements $ExampleTodosEventCopyWith<$Res> {
  factory $ExampleTodosTitleChangedCopyWith(ExampleTodosTitleChanged value, $Res Function(ExampleTodosTitleChanged) _then) = _$ExampleTodosTitleChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$ExampleTodosTitleChangedCopyWithImpl<$Res>
    implements $ExampleTodosTitleChangedCopyWith<$Res> {
  _$ExampleTodosTitleChangedCopyWithImpl(this._self, this._then);

  final ExampleTodosTitleChanged _self;
  final $Res Function(ExampleTodosTitleChanged) _then;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(ExampleTodosTitleChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExampleTodosDescriptionChanged implements ExampleTodosEvent {
  const ExampleTodosDescriptionChanged(this.value);
  

 final  String value;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodosDescriptionChangedCopyWith<ExampleTodosDescriptionChanged> get copyWith => _$ExampleTodosDescriptionChangedCopyWithImpl<ExampleTodosDescriptionChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosDescriptionChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ExampleTodosEvent.descriptionChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $ExampleTodosDescriptionChangedCopyWith<$Res> implements $ExampleTodosEventCopyWith<$Res> {
  factory $ExampleTodosDescriptionChangedCopyWith(ExampleTodosDescriptionChanged value, $Res Function(ExampleTodosDescriptionChanged) _then) = _$ExampleTodosDescriptionChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$ExampleTodosDescriptionChangedCopyWithImpl<$Res>
    implements $ExampleTodosDescriptionChangedCopyWith<$Res> {
  _$ExampleTodosDescriptionChangedCopyWithImpl(this._self, this._then);

  final ExampleTodosDescriptionChanged _self;
  final $Res Function(ExampleTodosDescriptionChanged) _then;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(ExampleTodosDescriptionChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExampleTodosDoneChanged implements ExampleTodosEvent {
  const ExampleTodosDoneChanged(this.value);
  

 final  bool value;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodosDoneChangedCopyWith<ExampleTodosDoneChanged> get copyWith => _$ExampleTodosDoneChangedCopyWithImpl<ExampleTodosDoneChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosDoneChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ExampleTodosEvent.doneChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class $ExampleTodosDoneChangedCopyWith<$Res> implements $ExampleTodosEventCopyWith<$Res> {
  factory $ExampleTodosDoneChangedCopyWith(ExampleTodosDoneChanged value, $Res Function(ExampleTodosDoneChanged) _then) = _$ExampleTodosDoneChangedCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$ExampleTodosDoneChangedCopyWithImpl<$Res>
    implements $ExampleTodosDoneChangedCopyWith<$Res> {
  _$ExampleTodosDoneChangedCopyWithImpl(this._self, this._then);

  final ExampleTodosDoneChanged _self;
  final $Res Function(ExampleTodosDoneChanged) _then;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(ExampleTodosDoneChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ExampleTodosEditRequested implements ExampleTodosEvent {
  const ExampleTodosEditRequested(this.todo);
  

 final  Todo todo;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodosEditRequestedCopyWith<ExampleTodosEditRequested> get copyWith => _$ExampleTodosEditRequestedCopyWithImpl<ExampleTodosEditRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosEditRequested&&(identical(other.todo, todo) || other.todo == todo));
}


@override
int get hashCode => Object.hash(runtimeType,todo);

@override
String toString() {
  return 'ExampleTodosEvent.editRequested(todo: $todo)';
}


}

/// @nodoc
abstract mixin class $ExampleTodosEditRequestedCopyWith<$Res> implements $ExampleTodosEventCopyWith<$Res> {
  factory $ExampleTodosEditRequestedCopyWith(ExampleTodosEditRequested value, $Res Function(ExampleTodosEditRequested) _then) = _$ExampleTodosEditRequestedCopyWithImpl;
@useResult
$Res call({
 Todo todo
});




}
/// @nodoc
class _$ExampleTodosEditRequestedCopyWithImpl<$Res>
    implements $ExampleTodosEditRequestedCopyWith<$Res> {
  _$ExampleTodosEditRequestedCopyWithImpl(this._self, this._then);

  final ExampleTodosEditRequested _self;
  final $Res Function(ExampleTodosEditRequested) _then;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todo = null,}) {
  return _then(ExampleTodosEditRequested(
null == todo ? _self.todo : todo // ignore: cast_nullable_to_non_nullable
as Todo,
  ));
}


}

/// @nodoc


class ExampleTodosClearRequested implements ExampleTodosEvent {
  const ExampleTodosClearRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosClearRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExampleTodosEvent.clearRequested()';
}


}




/// @nodoc


class ExampleTodosSubmitted implements ExampleTodosEvent {
  const ExampleTodosSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExampleTodosEvent.submitted()';
}


}




/// @nodoc


class ExampleTodosDeleted implements ExampleTodosEvent {
  const ExampleTodosDeleted(this.id);
  

 final  String id;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodosDeletedCopyWith<ExampleTodosDeleted> get copyWith => _$ExampleTodosDeletedCopyWithImpl<ExampleTodosDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosDeleted&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ExampleTodosEvent.deleted(id: $id)';
}


}

/// @nodoc
abstract mixin class $ExampleTodosDeletedCopyWith<$Res> implements $ExampleTodosEventCopyWith<$Res> {
  factory $ExampleTodosDeletedCopyWith(ExampleTodosDeleted value, $Res Function(ExampleTodosDeleted) _then) = _$ExampleTodosDeletedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$ExampleTodosDeletedCopyWithImpl<$Res>
    implements $ExampleTodosDeletedCopyWith<$Res> {
  _$ExampleTodosDeletedCopyWithImpl(this._self, this._then);

  final ExampleTodosDeleted _self;
  final $Res Function(ExampleTodosDeleted) _then;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ExampleTodosDeleted(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExampleTodosToggled implements ExampleTodosEvent {
  const ExampleTodosToggled(this.todo);
  

 final  Todo todo;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodosToggledCopyWith<ExampleTodosToggled> get copyWith => _$ExampleTodosToggledCopyWithImpl<ExampleTodosToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosToggled&&(identical(other.todo, todo) || other.todo == todo));
}


@override
int get hashCode => Object.hash(runtimeType,todo);

@override
String toString() {
  return 'ExampleTodosEvent.toggled(todo: $todo)';
}


}

/// @nodoc
abstract mixin class $ExampleTodosToggledCopyWith<$Res> implements $ExampleTodosEventCopyWith<$Res> {
  factory $ExampleTodosToggledCopyWith(ExampleTodosToggled value, $Res Function(ExampleTodosToggled) _then) = _$ExampleTodosToggledCopyWithImpl;
@useResult
$Res call({
 Todo todo
});




}
/// @nodoc
class _$ExampleTodosToggledCopyWithImpl<$Res>
    implements $ExampleTodosToggledCopyWith<$Res> {
  _$ExampleTodosToggledCopyWithImpl(this._self, this._then);

  final ExampleTodosToggled _self;
  final $Res Function(ExampleTodosToggled) _then;

/// Create a copy of ExampleTodosEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? todo = null,}) {
  return _then(ExampleTodosToggled(
null == todo ? _self.todo : todo // ignore: cast_nullable_to_non_nullable
as Todo,
  ));
}


}

/// @nodoc
mixin _$ExampleTodosState {

 List<Todo> get todos; StateStatus get status; Failure? get failure; FieldState<String> get titleField; FieldState<String> get descriptionField; FieldState<bool> get isDoneField; String? get editingTodoId; int get formVersion;
/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleTodosStateCopyWith<ExampleTodosState> get copyWith => _$ExampleTodosStateCopyWithImpl<ExampleTodosState>(this as ExampleTodosState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleTodosState&&const DeepCollectionEquality().equals(other.todos, todos)&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.titleField, titleField) || other.titleField == titleField)&&(identical(other.descriptionField, descriptionField) || other.descriptionField == descriptionField)&&(identical(other.isDoneField, isDoneField) || other.isDoneField == isDoneField)&&(identical(other.editingTodoId, editingTodoId) || other.editingTodoId == editingTodoId)&&(identical(other.formVersion, formVersion) || other.formVersion == formVersion));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(todos),status,failure,titleField,descriptionField,isDoneField,editingTodoId,formVersion);

@override
String toString() {
  return 'ExampleTodosState(todos: $todos, status: $status, failure: $failure, titleField: $titleField, descriptionField: $descriptionField, isDoneField: $isDoneField, editingTodoId: $editingTodoId, formVersion: $formVersion)';
}


}

/// @nodoc
abstract mixin class $ExampleTodosStateCopyWith<$Res>  {
  factory $ExampleTodosStateCopyWith(ExampleTodosState value, $Res Function(ExampleTodosState) _then) = _$ExampleTodosStateCopyWithImpl;
@useResult
$Res call({
 List<Todo> todos, StateStatus status, Failure? failure, FieldState<String> titleField, FieldState<String> descriptionField, FieldState<bool> isDoneField, String? editingTodoId, int formVersion
});


$FailureCopyWith<$Res>? get failure;$FieldStateCopyWith<String, $Res> get titleField;$FieldStateCopyWith<String, $Res> get descriptionField;$FieldStateCopyWith<bool, $Res> get isDoneField;

}
/// @nodoc
class _$ExampleTodosStateCopyWithImpl<$Res>
    implements $ExampleTodosStateCopyWith<$Res> {
  _$ExampleTodosStateCopyWithImpl(this._self, this._then);

  final ExampleTodosState _self;
  final $Res Function(ExampleTodosState) _then;

/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todos = null,Object? status = null,Object? failure = freezed,Object? titleField = null,Object? descriptionField = null,Object? isDoneField = null,Object? editingTodoId = freezed,Object? formVersion = null,}) {
  return _then(_self.copyWith(
todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,titleField: null == titleField ? _self.titleField : titleField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,descriptionField: null == descriptionField ? _self.descriptionField : descriptionField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,isDoneField: null == isDoneField ? _self.isDoneField : isDoneField // ignore: cast_nullable_to_non_nullable
as FieldState<bool>,editingTodoId: freezed == editingTodoId ? _self.editingTodoId : editingTodoId // ignore: cast_nullable_to_non_nullable
as String?,formVersion: null == formVersion ? _self.formVersion : formVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get titleField {
  
  return $FieldStateCopyWith<String, $Res>(_self.titleField, (value) {
    return _then(_self.copyWith(titleField: value));
  });
}/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get descriptionField {
  
  return $FieldStateCopyWith<String, $Res>(_self.descriptionField, (value) {
    return _then(_self.copyWith(descriptionField: value));
  });
}/// Create a copy of ExampleTodosState
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


class _ExampleTodosState implements ExampleTodosState {
  const _ExampleTodosState({final  List<Todo> todos = const <Todo>[], this.status = StateStatus.initial, this.failure, this.titleField = const FieldState(value: ''), this.descriptionField = const FieldState(value: ''), this.isDoneField = const FieldState(value: false), this.editingTodoId, this.formVersion = 0}): _todos = todos;
  

 final  List<Todo> _todos;
@override@JsonKey() List<Todo> get todos {
  if (_todos is EqualUnmodifiableListView) return _todos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todos);
}

@override@JsonKey() final  StateStatus status;
@override final  Failure? failure;
@override@JsonKey() final  FieldState<String> titleField;
@override@JsonKey() final  FieldState<String> descriptionField;
@override@JsonKey() final  FieldState<bool> isDoneField;
@override final  String? editingTodoId;
@override@JsonKey() final  int formVersion;

/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleTodosStateCopyWith<_ExampleTodosState> get copyWith => __$ExampleTodosStateCopyWithImpl<_ExampleTodosState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExampleTodosState&&const DeepCollectionEquality().equals(other._todos, _todos)&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.titleField, titleField) || other.titleField == titleField)&&(identical(other.descriptionField, descriptionField) || other.descriptionField == descriptionField)&&(identical(other.isDoneField, isDoneField) || other.isDoneField == isDoneField)&&(identical(other.editingTodoId, editingTodoId) || other.editingTodoId == editingTodoId)&&(identical(other.formVersion, formVersion) || other.formVersion == formVersion));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_todos),status,failure,titleField,descriptionField,isDoneField,editingTodoId,formVersion);

@override
String toString() {
  return 'ExampleTodosState(todos: $todos, status: $status, failure: $failure, titleField: $titleField, descriptionField: $descriptionField, isDoneField: $isDoneField, editingTodoId: $editingTodoId, formVersion: $formVersion)';
}


}

/// @nodoc
abstract mixin class _$ExampleTodosStateCopyWith<$Res> implements $ExampleTodosStateCopyWith<$Res> {
  factory _$ExampleTodosStateCopyWith(_ExampleTodosState value, $Res Function(_ExampleTodosState) _then) = __$ExampleTodosStateCopyWithImpl;
@override @useResult
$Res call({
 List<Todo> todos, StateStatus status, Failure? failure, FieldState<String> titleField, FieldState<String> descriptionField, FieldState<bool> isDoneField, String? editingTodoId, int formVersion
});


@override $FailureCopyWith<$Res>? get failure;@override $FieldStateCopyWith<String, $Res> get titleField;@override $FieldStateCopyWith<String, $Res> get descriptionField;@override $FieldStateCopyWith<bool, $Res> get isDoneField;

}
/// @nodoc
class __$ExampleTodosStateCopyWithImpl<$Res>
    implements _$ExampleTodosStateCopyWith<$Res> {
  __$ExampleTodosStateCopyWithImpl(this._self, this._then);

  final _ExampleTodosState _self;
  final $Res Function(_ExampleTodosState) _then;

/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todos = null,Object? status = null,Object? failure = freezed,Object? titleField = null,Object? descriptionField = null,Object? isDoneField = null,Object? editingTodoId = freezed,Object? formVersion = null,}) {
  return _then(_ExampleTodosState(
todos: null == todos ? _self._todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,titleField: null == titleField ? _self.titleField : titleField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,descriptionField: null == descriptionField ? _self.descriptionField : descriptionField // ignore: cast_nullable_to_non_nullable
as FieldState<String>,isDoneField: null == isDoneField ? _self.isDoneField : isDoneField // ignore: cast_nullable_to_non_nullable
as FieldState<bool>,editingTodoId: freezed == editingTodoId ? _self.editingTodoId : editingTodoId // ignore: cast_nullable_to_non_nullable
as String?,formVersion: null == formVersion ? _self.formVersion : formVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get titleField {
  
  return $FieldStateCopyWith<String, $Res>(_self.titleField, (value) {
    return _then(_self.copyWith(titleField: value));
  });
}/// Create a copy of ExampleTodosState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldStateCopyWith<String, $Res> get descriptionField {
  
  return $FieldStateCopyWith<String, $Res>(_self.descriptionField, (value) {
    return _then(_self.copyWith(descriptionField: value));
  });
}/// Create a copy of ExampleTodosState
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
