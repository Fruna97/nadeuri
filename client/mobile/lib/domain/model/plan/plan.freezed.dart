// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Plan {

 String? get uuid; String get title; String? get googlePlacesId; double? get latitude; double? get longitude; DateTime get startAt; DateTime get endAt; String get nadeuriUuid;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);

  /// Serializes this Plan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.googlePlacesId, googlePlacesId) || other.googlePlacesId == googlePlacesId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.nadeuriUuid, nadeuriUuid) || other.nadeuriUuid == nadeuriUuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,googlePlacesId,latitude,longitude,startAt,endAt,nadeuriUuid);

@override
String toString() {
  return 'Plan(uuid: $uuid, title: $title, googlePlacesId: $googlePlacesId, latitude: $latitude, longitude: $longitude, startAt: $startAt, endAt: $endAt, nadeuriUuid: $nadeuriUuid)';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 String? uuid, String title, String? googlePlacesId, double? latitude, double? longitude, DateTime startAt, DateTime endAt, String nadeuriUuid
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = freezed,Object? title = null,Object? googlePlacesId = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? startAt = null,Object? endAt = null,Object? nadeuriUuid = null,}) {
  return _then(_self.copyWith(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,googlePlacesId: freezed == googlePlacesId ? _self.googlePlacesId : googlePlacesId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,nadeuriUuid: null == nadeuriUuid ? _self.nadeuriUuid : nadeuriUuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? uuid,  String title,  String? googlePlacesId,  double? latitude,  double? longitude,  DateTime startAt,  DateTime endAt,  String nadeuriUuid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.uuid,_that.title,_that.googlePlacesId,_that.latitude,_that.longitude,_that.startAt,_that.endAt,_that.nadeuriUuid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? uuid,  String title,  String? googlePlacesId,  double? latitude,  double? longitude,  DateTime startAt,  DateTime endAt,  String nadeuriUuid)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.uuid,_that.title,_that.googlePlacesId,_that.latitude,_that.longitude,_that.startAt,_that.endAt,_that.nadeuriUuid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? uuid,  String title,  String? googlePlacesId,  double? latitude,  double? longitude,  DateTime startAt,  DateTime endAt,  String nadeuriUuid)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.uuid,_that.title,_that.googlePlacesId,_that.latitude,_that.longitude,_that.startAt,_that.endAt,_that.nadeuriUuid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Plan implements Plan {
  const _Plan({this.uuid, required this.title, this.googlePlacesId, this.latitude, this.longitude, required this.startAt, required this.endAt, required this.nadeuriUuid});
  factory _Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

@override final  String? uuid;
@override final  String title;
@override final  String? googlePlacesId;
@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime startAt;
@override final  DateTime endAt;
@override final  String nadeuriUuid;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&(identical(other.googlePlacesId, googlePlacesId) || other.googlePlacesId == googlePlacesId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.nadeuriUuid, nadeuriUuid) || other.nadeuriUuid == nadeuriUuid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,googlePlacesId,latitude,longitude,startAt,endAt,nadeuriUuid);

@override
String toString() {
  return 'Plan(uuid: $uuid, title: $title, googlePlacesId: $googlePlacesId, latitude: $latitude, longitude: $longitude, startAt: $startAt, endAt: $endAt, nadeuriUuid: $nadeuriUuid)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 String? uuid, String title, String? googlePlacesId, double? latitude, double? longitude, DateTime startAt, DateTime endAt, String nadeuriUuid
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = freezed,Object? title = null,Object? googlePlacesId = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? startAt = null,Object? endAt = null,Object? nadeuriUuid = null,}) {
  return _then(_Plan(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,googlePlacesId: freezed == googlePlacesId ? _self.googlePlacesId : googlePlacesId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,nadeuriUuid: null == nadeuriUuid ? _self.nadeuriUuid : nadeuriUuid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
