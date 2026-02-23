// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanApiModel implements DiagnosticableTreeMixin {

 String? get uuid; String get title; String? get googlePlacesId; bool get allDay; DateTime get startAt; DateTime get endAt; String get nadeuriUuid;
/// Create a copy of PlanApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanApiModelCopyWith<PlanApiModel> get copyWith => _$PlanApiModelCopyWithImpl<PlanApiModel>(this as PlanApiModel, _$identity);

  /// Serializes this PlanApiModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlanApiModel'))
    ..add(DiagnosticsProperty('uuid', uuid))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('googlePlacesId', googlePlacesId))..add(DiagnosticsProperty('allDay', allDay))..add(DiagnosticsProperty('startAt', startAt))..add(DiagnosticsProperty('endAt', endAt))..add(DiagnosticsProperty('nadeuriUuid', nadeuriUuid));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.googlePlacesId, googlePlacesId) || other.googlePlacesId == googlePlacesId)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.nadeuriUuid, nadeuriUuid) || other.nadeuriUuid == nadeuriUuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,googlePlacesId,allDay,startAt,endAt,nadeuriUuid);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlanApiModel(uuid: $uuid, title: $title, googlePlacesId: $googlePlacesId, allDay: $allDay, startAt: $startAt, endAt: $endAt, nadeuriUuid: $nadeuriUuid)';
}


}

/// @nodoc
abstract mixin class $PlanApiModelCopyWith<$Res>  {
  factory $PlanApiModelCopyWith(PlanApiModel value, $Res Function(PlanApiModel) _then) = _$PlanApiModelCopyWithImpl;
@useResult
$Res call({
 String? uuid, String title, String? googlePlacesId, bool allDay, DateTime startAt, DateTime endAt, String nadeuriUuid
});




}
/// @nodoc
class _$PlanApiModelCopyWithImpl<$Res>
    implements $PlanApiModelCopyWith<$Res> {
  _$PlanApiModelCopyWithImpl(this._self, this._then);

  final PlanApiModel _self;
  final $Res Function(PlanApiModel) _then;

/// Create a copy of PlanApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = freezed,Object? title = null,Object? googlePlacesId = freezed,Object? allDay = null,Object? startAt = null,Object? endAt = null,Object? nadeuriUuid = null,}) {
  return _then(_self.copyWith(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,googlePlacesId: freezed == googlePlacesId ? _self.googlePlacesId : googlePlacesId // ignore: cast_nullable_to_non_nullable
as String?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,nadeuriUuid: null == nadeuriUuid ? _self.nadeuriUuid : nadeuriUuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanApiModel].
extension PlanApiModelPatterns on PlanApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanApiModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanApiModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanApiModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanApiModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? uuid,  String title,  String? googlePlacesId,  bool allDay,  DateTime startAt,  DateTime endAt,  String nadeuriUuid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanApiModel() when $default != null:
return $default(_that.uuid,_that.title,_that.googlePlacesId,_that.allDay,_that.startAt,_that.endAt,_that.nadeuriUuid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? uuid,  String title,  String? googlePlacesId,  bool allDay,  DateTime startAt,  DateTime endAt,  String nadeuriUuid)  $default,) {final _that = this;
switch (_that) {
case _PlanApiModel():
return $default(_that.uuid,_that.title,_that.googlePlacesId,_that.allDay,_that.startAt,_that.endAt,_that.nadeuriUuid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? uuid,  String title,  String? googlePlacesId,  bool allDay,  DateTime startAt,  DateTime endAt,  String nadeuriUuid)?  $default,) {final _that = this;
switch (_that) {
case _PlanApiModel() when $default != null:
return $default(_that.uuid,_that.title,_that.googlePlacesId,_that.allDay,_that.startAt,_that.endAt,_that.nadeuriUuid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanApiModel extends PlanApiModel with DiagnosticableTreeMixin {
  const _PlanApiModel({this.uuid, required this.title, this.googlePlacesId, required this.allDay, required this.startAt, required this.endAt, required this.nadeuriUuid}): super._();
  factory _PlanApiModel.fromJson(Map<String, dynamic> json) => _$PlanApiModelFromJson(json);

@override final  String? uuid;
@override final  String title;
@override final  String? googlePlacesId;
@override final  bool allDay;
@override final  DateTime startAt;
@override final  DateTime endAt;
@override final  String nadeuriUuid;

/// Create a copy of PlanApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanApiModelCopyWith<_PlanApiModel> get copyWith => __$PlanApiModelCopyWithImpl<_PlanApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanApiModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PlanApiModel'))
    ..add(DiagnosticsProperty('uuid', uuid))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('googlePlacesId', googlePlacesId))..add(DiagnosticsProperty('allDay', allDay))..add(DiagnosticsProperty('startAt', startAt))..add(DiagnosticsProperty('endAt', endAt))..add(DiagnosticsProperty('nadeuriUuid', nadeuriUuid));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.googlePlacesId, googlePlacesId) || other.googlePlacesId == googlePlacesId)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.nadeuriUuid, nadeuriUuid) || other.nadeuriUuid == nadeuriUuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,googlePlacesId,allDay,startAt,endAt,nadeuriUuid);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PlanApiModel(uuid: $uuid, title: $title, googlePlacesId: $googlePlacesId, allDay: $allDay, startAt: $startAt, endAt: $endAt, nadeuriUuid: $nadeuriUuid)';
}


}

/// @nodoc
abstract mixin class _$PlanApiModelCopyWith<$Res> implements $PlanApiModelCopyWith<$Res> {
  factory _$PlanApiModelCopyWith(_PlanApiModel value, $Res Function(_PlanApiModel) _then) = __$PlanApiModelCopyWithImpl;
@override @useResult
$Res call({
 String? uuid, String title, String? googlePlacesId, bool allDay, DateTime startAt, DateTime endAt, String nadeuriUuid
});




}
/// @nodoc
class __$PlanApiModelCopyWithImpl<$Res>
    implements _$PlanApiModelCopyWith<$Res> {
  __$PlanApiModelCopyWithImpl(this._self, this._then);

  final _PlanApiModel _self;
  final $Res Function(_PlanApiModel) _then;

/// Create a copy of PlanApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = freezed,Object? title = null,Object? googlePlacesId = freezed,Object? allDay = null,Object? startAt = null,Object? endAt = null,Object? nadeuriUuid = null,}) {
  return _then(_PlanApiModel(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,googlePlacesId: freezed == googlePlacesId ? _self.googlePlacesId : googlePlacesId // ignore: cast_nullable_to_non_nullable
as String?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,nadeuriUuid: null == nadeuriUuid ? _self.nadeuriUuid : nadeuriUuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
