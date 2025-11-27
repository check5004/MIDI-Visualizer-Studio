// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent()';
}


}

/// @nodoc
class $EditorEventCopyWith<$Res>  {
$EditorEventCopyWith(EditorEvent _, $Res Function(EditorEvent) __);
}


/// Adds pattern-matching-related methods to [EditorEvent].
extension EditorEventPatterns on EditorEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProject value)?  loadProject,TResult Function( AddComponent value)?  addComponent,TResult Function( UpdateComponent value)?  updateComponent,TResult Function( SelectComponent value)?  selectComponent,TResult Function( ReorderComponent value)?  reorderComponent,TResult Function( UpdateProjectSettings value)?  updateProjectSettings,TResult Function( ToggleMode value)?  toggleMode,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that);case AddComponent() when addComponent != null:
return addComponent(_that);case UpdateComponent() when updateComponent != null:
return updateComponent(_that);case SelectComponent() when selectComponent != null:
return selectComponent(_that);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that);case ToggleMode() when toggleMode != null:
return toggleMode(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProject value)  loadProject,required TResult Function( AddComponent value)  addComponent,required TResult Function( UpdateComponent value)  updateComponent,required TResult Function( SelectComponent value)  selectComponent,required TResult Function( ReorderComponent value)  reorderComponent,required TResult Function( UpdateProjectSettings value)  updateProjectSettings,required TResult Function( ToggleMode value)  toggleMode,}){
final _that = this;
switch (_that) {
case LoadProject():
return loadProject(_that);case AddComponent():
return addComponent(_that);case UpdateComponent():
return updateComponent(_that);case SelectComponent():
return selectComponent(_that);case ReorderComponent():
return reorderComponent(_that);case UpdateProjectSettings():
return updateProjectSettings(_that);case ToggleMode():
return toggleMode(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProject value)?  loadProject,TResult? Function( AddComponent value)?  addComponent,TResult? Function( UpdateComponent value)?  updateComponent,TResult? Function( SelectComponent value)?  selectComponent,TResult? Function( ReorderComponent value)?  reorderComponent,TResult? Function( UpdateProjectSettings value)?  updateProjectSettings,TResult? Function( ToggleMode value)?  toggleMode,}){
final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that);case AddComponent() when addComponent != null:
return addComponent(_that);case UpdateComponent() when updateComponent != null:
return updateComponent(_that);case SelectComponent() when selectComponent != null:
return selectComponent(_that);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that);case ToggleMode() when toggleMode != null:
return toggleMode(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String path)?  loadProject,TResult Function( Component component)?  addComponent,TResult Function( String id,  Component component)?  updateComponent,TResult Function( String id,  bool multiSelect)?  selectComponent,TResult Function( int oldIndex,  int newIndex)?  reorderComponent,TResult Function( Project project)?  updateProjectSettings,TResult Function( EditorMode mode)?  toggleMode,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that.path);case AddComponent() when addComponent != null:
return addComponent(_that.component);case UpdateComponent() when updateComponent != null:
return updateComponent(_that.id,_that.component);case SelectComponent() when selectComponent != null:
return selectComponent(_that.id,_that.multiSelect);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that.oldIndex,_that.newIndex);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that.project);case ToggleMode() when toggleMode != null:
return toggleMode(_that.mode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String path)  loadProject,required TResult Function( Component component)  addComponent,required TResult Function( String id,  Component component)  updateComponent,required TResult Function( String id,  bool multiSelect)  selectComponent,required TResult Function( int oldIndex,  int newIndex)  reorderComponent,required TResult Function( Project project)  updateProjectSettings,required TResult Function( EditorMode mode)  toggleMode,}) {final _that = this;
switch (_that) {
case LoadProject():
return loadProject(_that.path);case AddComponent():
return addComponent(_that.component);case UpdateComponent():
return updateComponent(_that.id,_that.component);case SelectComponent():
return selectComponent(_that.id,_that.multiSelect);case ReorderComponent():
return reorderComponent(_that.oldIndex,_that.newIndex);case UpdateProjectSettings():
return updateProjectSettings(_that.project);case ToggleMode():
return toggleMode(_that.mode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String path)?  loadProject,TResult? Function( Component component)?  addComponent,TResult? Function( String id,  Component component)?  updateComponent,TResult? Function( String id,  bool multiSelect)?  selectComponent,TResult? Function( int oldIndex,  int newIndex)?  reorderComponent,TResult? Function( Project project)?  updateProjectSettings,TResult? Function( EditorMode mode)?  toggleMode,}) {final _that = this;
switch (_that) {
case LoadProject() when loadProject != null:
return loadProject(_that.path);case AddComponent() when addComponent != null:
return addComponent(_that.component);case UpdateComponent() when updateComponent != null:
return updateComponent(_that.id,_that.component);case SelectComponent() when selectComponent != null:
return selectComponent(_that.id,_that.multiSelect);case ReorderComponent() when reorderComponent != null:
return reorderComponent(_that.oldIndex,_that.newIndex);case UpdateProjectSettings() when updateProjectSettings != null:
return updateProjectSettings(_that.project);case ToggleMode() when toggleMode != null:
return toggleMode(_that.mode);case _:
  return null;

}
}

}

/// @nodoc


class LoadProject implements EditorEvent {
  const LoadProject(this.path);
  

 final  String path;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadProjectCopyWith<LoadProject> get copyWith => _$LoadProjectCopyWithImpl<LoadProject>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProject&&(identical(other.path, path) || other.path == path));
}


@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'EditorEvent.loadProject(path: $path)';
}


}

/// @nodoc
abstract mixin class $LoadProjectCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $LoadProjectCopyWith(LoadProject value, $Res Function(LoadProject) _then) = _$LoadProjectCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class _$LoadProjectCopyWithImpl<$Res>
    implements $LoadProjectCopyWith<$Res> {
  _$LoadProjectCopyWithImpl(this._self, this._then);

  final LoadProject _self;
  final $Res Function(LoadProject) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(LoadProject(
null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddComponent implements EditorEvent {
  const AddComponent(this.component);
  

 final  Component component;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddComponentCopyWith<AddComponent> get copyWith => _$AddComponentCopyWithImpl<AddComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddComponent&&(identical(other.component, component) || other.component == component));
}


@override
int get hashCode => Object.hash(runtimeType,component);

@override
String toString() {
  return 'EditorEvent.addComponent(component: $component)';
}


}

/// @nodoc
abstract mixin class $AddComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $AddComponentCopyWith(AddComponent value, $Res Function(AddComponent) _then) = _$AddComponentCopyWithImpl;
@useResult
$Res call({
 Component component
});


$ComponentCopyWith<$Res> get component;

}
/// @nodoc
class _$AddComponentCopyWithImpl<$Res>
    implements $AddComponentCopyWith<$Res> {
  _$AddComponentCopyWithImpl(this._self, this._then);

  final AddComponent _self;
  final $Res Function(AddComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? component = null,}) {
  return _then(AddComponent(
null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as Component,
  ));
}

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComponentCopyWith<$Res> get component {
  
  return $ComponentCopyWith<$Res>(_self.component, (value) {
    return _then(_self.copyWith(component: value));
  });
}
}

/// @nodoc


class UpdateComponent implements EditorEvent {
  const UpdateComponent(this.id, this.component);
  

 final  String id;
 final  Component component;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateComponentCopyWith<UpdateComponent> get copyWith => _$UpdateComponentCopyWithImpl<UpdateComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateComponent&&(identical(other.id, id) || other.id == id)&&(identical(other.component, component) || other.component == component));
}


@override
int get hashCode => Object.hash(runtimeType,id,component);

@override
String toString() {
  return 'EditorEvent.updateComponent(id: $id, component: $component)';
}


}

/// @nodoc
abstract mixin class $UpdateComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $UpdateComponentCopyWith(UpdateComponent value, $Res Function(UpdateComponent) _then) = _$UpdateComponentCopyWithImpl;
@useResult
$Res call({
 String id, Component component
});


$ComponentCopyWith<$Res> get component;

}
/// @nodoc
class _$UpdateComponentCopyWithImpl<$Res>
    implements $UpdateComponentCopyWith<$Res> {
  _$UpdateComponentCopyWithImpl(this._self, this._then);

  final UpdateComponent _self;
  final $Res Function(UpdateComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? component = null,}) {
  return _then(UpdateComponent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as Component,
  ));
}

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComponentCopyWith<$Res> get component {
  
  return $ComponentCopyWith<$Res>(_self.component, (value) {
    return _then(_self.copyWith(component: value));
  });
}
}

/// @nodoc


class SelectComponent implements EditorEvent {
  const SelectComponent(this.id, {required this.multiSelect});
  

 final  String id;
 final  bool multiSelect;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectComponentCopyWith<SelectComponent> get copyWith => _$SelectComponentCopyWithImpl<SelectComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectComponent&&(identical(other.id, id) || other.id == id)&&(identical(other.multiSelect, multiSelect) || other.multiSelect == multiSelect));
}


@override
int get hashCode => Object.hash(runtimeType,id,multiSelect);

@override
String toString() {
  return 'EditorEvent.selectComponent(id: $id, multiSelect: $multiSelect)';
}


}

/// @nodoc
abstract mixin class $SelectComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $SelectComponentCopyWith(SelectComponent value, $Res Function(SelectComponent) _then) = _$SelectComponentCopyWithImpl;
@useResult
$Res call({
 String id, bool multiSelect
});




}
/// @nodoc
class _$SelectComponentCopyWithImpl<$Res>
    implements $SelectComponentCopyWith<$Res> {
  _$SelectComponentCopyWithImpl(this._self, this._then);

  final SelectComponent _self;
  final $Res Function(SelectComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? multiSelect = null,}) {
  return _then(SelectComponent(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,multiSelect: null == multiSelect ? _self.multiSelect : multiSelect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ReorderComponent implements EditorEvent {
  const ReorderComponent(this.oldIndex, this.newIndex);
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReorderComponentCopyWith<ReorderComponent> get copyWith => _$ReorderComponentCopyWithImpl<ReorderComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReorderComponent&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,oldIndex,newIndex);

@override
String toString() {
  return 'EditorEvent.reorderComponent(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $ReorderComponentCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $ReorderComponentCopyWith(ReorderComponent value, $Res Function(ReorderComponent) _then) = _$ReorderComponentCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class _$ReorderComponentCopyWithImpl<$Res>
    implements $ReorderComponentCopyWith<$Res> {
  _$ReorderComponentCopyWithImpl(this._self, this._then);

  final ReorderComponent _self;
  final $Res Function(ReorderComponent) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(ReorderComponent(
null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UpdateProjectSettings implements EditorEvent {
  const UpdateProjectSettings(this.project);
  

 final  Project project;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProjectSettingsCopyWith<UpdateProjectSettings> get copyWith => _$UpdateProjectSettingsCopyWithImpl<UpdateProjectSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProjectSettings&&(identical(other.project, project) || other.project == project));
}


@override
int get hashCode => Object.hash(runtimeType,project);

@override
String toString() {
  return 'EditorEvent.updateProjectSettings(project: $project)';
}


}

/// @nodoc
abstract mixin class $UpdateProjectSettingsCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $UpdateProjectSettingsCopyWith(UpdateProjectSettings value, $Res Function(UpdateProjectSettings) _then) = _$UpdateProjectSettingsCopyWithImpl;
@useResult
$Res call({
 Project project
});


$ProjectCopyWith<$Res> get project;

}
/// @nodoc
class _$UpdateProjectSettingsCopyWithImpl<$Res>
    implements $UpdateProjectSettingsCopyWith<$Res> {
  _$UpdateProjectSettingsCopyWithImpl(this._self, this._then);

  final UpdateProjectSettings _self;
  final $Res Function(UpdateProjectSettings) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? project = null,}) {
  return _then(UpdateProjectSettings(
null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as Project,
  ));
}

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProjectCopyWith<$Res> get project {
  
  return $ProjectCopyWith<$Res>(_self.project, (value) {
    return _then(_self.copyWith(project: value));
  });
}
}

/// @nodoc


class ToggleMode implements EditorEvent {
  const ToggleMode(this.mode);
  

 final  EditorMode mode;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleModeCopyWith<ToggleMode> get copyWith => _$ToggleModeCopyWithImpl<ToggleMode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleMode&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'EditorEvent.toggleMode(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ToggleModeCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory $ToggleModeCopyWith(ToggleMode value, $Res Function(ToggleMode) _then) = _$ToggleModeCopyWithImpl;
@useResult
$Res call({
 EditorMode mode
});




}
/// @nodoc
class _$ToggleModeCopyWithImpl<$Res>
    implements $ToggleModeCopyWith<$Res> {
  _$ToggleModeCopyWithImpl(this._self, this._then);

  final ToggleMode _self;
  final $Res Function(ToggleMode) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(ToggleMode(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as EditorMode,
  ));
}


}

// dart format on
