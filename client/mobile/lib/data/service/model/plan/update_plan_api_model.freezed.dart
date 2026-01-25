// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_plan_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdatePlanApiModel {

 String get title; String? get googlePlacesId; double? get latitude; double? get longitude; bool get allDay; DateTime get startAt; DateTime get endAt;
/// Create a copy of UpdatePlanApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdatePlanApiModelCopyWith<UpdatePlanApiModel> get copyWith => _$UpdatePlanApiModelCopyWithImpl<UpdatePlanApiModel>(this as UpdatePlanApiModel, _$identity);

  /// Serializes this UpdatePlanApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdatePlanApiModel&&(identical(other.title, title) || other.title == title)&&(identical(other.googlePlacesId, googlePlacesId) || other.googlePlacesId == googlePlacesId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,googlePlacesId,latitude,longitude,allDay,startAt,endAt);

@override
String toString() {
  return 'UpdatePlanApiModel(title: $title, googlePlacesId: $googlePlacesId, latitude: $latitude, longitude: $longitude, allDay: $allDay, startAt: $startAt, endAt: $endAt)';
}


}

/// @nodoc
abstract mixin class $UpdatePlanApiModelCopyWith<$Res>  {
  factory $UpdatePlanApiModelCopyWith(UpdatePlanApiModel value, $Res Function(UpdatePlanApiModel) _then) = _$UpdatePlanApiModelCopyWithImpl;
@useResult
$Res call({
 String title, String? googlePlacesId, double? latitude, double? longitude, bool allDay, DateTime startAt, DateTime endAt
});




}
/// @nodoc
class _$UpdatePlanApiModelCopyWithImpl<$Res>
    implements $UpdatePlanApiModelCopyWith<$Res> {
  _$UpdatePlanApiModelCopyWithImpl(this._self, this._then);

  final UpdatePlanApiModel _self;
  final $Res Function(UpdatePlanApiModel) _then;

/// Create a copy of UpdatePlanApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? googlePlacesId = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? allDay = null,Object? startAt = null,Object? endAt = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,googlePlacesId: freezed == googlePlacesId ? _self.googlePlacesId : googlePlacesId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdatePlanApiModel].
extension UpdatePlanApiModelPatterns on UpdatePlanApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdatePlanApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdatePlanApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdatePlanApiModel value)  $default,){
final _that = this;
switch (_that) {
case _UpdatePlanApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdatePlanApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _UpdatePlanApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? googlePlacesId,  double? latitude,  double? longitude,  bool allDay,  DateTime startAt,  DateTime endAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdatePlanApiModel() when $default != null:
return $default(_that.title,_that.googlePlacesId,_that.latitude,_that.longitude,_that.allDay,_that.startAt,_that.endAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? googlePlacesId,  double? latitude,  double? longitude,  bool allDay,  DateTime startAt,  DateTime endAt)  $default,) {final _that = this;
switch (_that) {
case _UpdatePlanApiModel():
return $default(_that.title,_that.googlePlacesId,_that.latitude,_that.longitude,_that.allDay,_that.startAt,_that.endAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? googlePlacesId,  double? latitude,  double? longitude,  bool allDay,  DateTime startAt,  DateTime endAt)?  $default,) {final _that = this;
switch (_that) {
case _UpdatePlanApiModel() when $default != null:
return $default(_that.title,_that.googlePlacesId,_that.latitude,_that.longitude,_that.allDay,_that.startAt,_that.endAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdatePlanApiModel extends UpdatePlanApiModel {
  const _UpdatePlanApiModel({required this.title, this.googlePlacesId, this.latitude, this.longitude, required this.allDay, required this.startAt, required this.endAt}): super._();
  factory _UpdatePlanApiModel.fromJson(Map<String, dynamic> json) => _$UpdatePlanApiModelFromJson(json);

@override final  String title;
@override final  String? googlePlacesId;
@override final  double? latitude;
@override final  double? longitude;
@override final  bool allDay;
@override final  DateTime startAt;
@override final  DateTime endAt;

/// Create a copy of UpdatePlanApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePlanApiModelCopyWith<_UpdatePlanApiModel> get copyWith => __$UpdatePlanApiModelCopyWithImpl<_UpdatePlanApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdatePlanApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePlanApiModel&&(identical(other.title, title) || other.title == title)&&(identical(other.googlePlacesId, googlePlacesId) || other.googlePlacesId == googlePlacesId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,googlePlacesId,latitude,longitude,allDay,startAt,endAt);

@override
String toString() {
  return 'UpdatePlanApiModel(title: $title, googlePlacesId: $googlePlacesId, latitude: $latitude, longitude: $longitude, allDay: $allDay, startAt: $startAt, endAt: $endAt)';
}


}

/// @nodoc
abstract mixin class _$UpdatePlanApiModelCopyWith<$Res> implements $UpdatePlanApiModelCopyWith<$Res> {
  factory _$UpdatePlanApiModelCopyWith(_UpdatePlanApiModel value, $Res Function(_UpdatePlanApiModel) _then) = __$UpdatePlanApiModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String? googlePlacesId, double? latitude, double? longitude, bool allDay, DateTime startAt, DateTime endAt
});




}
/// @nodoc
class __$UpdatePlanApiModelCopyWithImpl<$Res>
    implements _$UpdatePlanApiModelCopyWith<$Res> {
  __$UpdatePlanApiModelCopyWithImpl(this._self, this._then);

  final _UpdatePlanApiModel _self;
  final $Res Function(_UpdatePlanApiModel) _then;

/// Create a copy of UpdatePlanApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? googlePlacesId = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? allDay = null,Object? startAt = null,Object? endAt = null,}) {
  return _then(_UpdatePlanApiModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,googlePlacesId: freezed == googlePlacesId ? _self.googlePlacesId : googlePlacesId // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
