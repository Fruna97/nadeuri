// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_nadeuri_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateNadeuriApiModel {

 String get title;
/// Create a copy of UpdateNadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateNadeuriApiModelCopyWith<UpdateNadeuriApiModel> get copyWith => _$UpdateNadeuriApiModelCopyWithImpl<UpdateNadeuriApiModel>(this as UpdateNadeuriApiModel, _$identity);

  /// Serializes this UpdateNadeuriApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateNadeuriApiModel&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'UpdateNadeuriApiModel(title: $title)';
}


}

/// @nodoc
abstract mixin class $UpdateNadeuriApiModelCopyWith<$Res>  {
  factory $UpdateNadeuriApiModelCopyWith(UpdateNadeuriApiModel value, $Res Function(UpdateNadeuriApiModel) _then) = _$UpdateNadeuriApiModelCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class _$UpdateNadeuriApiModelCopyWithImpl<$Res>
    implements $UpdateNadeuriApiModelCopyWith<$Res> {
  _$UpdateNadeuriApiModelCopyWithImpl(this._self, this._then);

  final UpdateNadeuriApiModel _self;
  final $Res Function(UpdateNadeuriApiModel) _then;

/// Create a copy of UpdateNadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateNadeuriApiModel].
extension UpdateNadeuriApiModelPatterns on UpdateNadeuriApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateNadeuriApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateNadeuriApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateNadeuriApiModel value)  $default,){
final _that = this;
switch (_that) {
case _UpdateNadeuriApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateNadeuriApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateNadeuriApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateNadeuriApiModel() when $default != null:
return $default(_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title)  $default,) {final _that = this;
switch (_that) {
case _UpdateNadeuriApiModel():
return $default(_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title)?  $default,) {final _that = this;
switch (_that) {
case _UpdateNadeuriApiModel() when $default != null:
return $default(_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createFactory: false)

class _UpdateNadeuriApiModel implements UpdateNadeuriApiModel {
  const _UpdateNadeuriApiModel({required this.title});
  

@override final  String title;

/// Create a copy of UpdateNadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateNadeuriApiModelCopyWith<_UpdateNadeuriApiModel> get copyWith => __$UpdateNadeuriApiModelCopyWithImpl<_UpdateNadeuriApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateNadeuriApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateNadeuriApiModel&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'UpdateNadeuriApiModel(title: $title)';
}


}

/// @nodoc
abstract mixin class _$UpdateNadeuriApiModelCopyWith<$Res> implements $UpdateNadeuriApiModelCopyWith<$Res> {
  factory _$UpdateNadeuriApiModelCopyWith(_UpdateNadeuriApiModel value, $Res Function(_UpdateNadeuriApiModel) _then) = __$UpdateNadeuriApiModelCopyWithImpl;
@override @useResult
$Res call({
 String title
});




}
/// @nodoc
class __$UpdateNadeuriApiModelCopyWithImpl<$Res>
    implements _$UpdateNadeuriApiModelCopyWith<$Res> {
  __$UpdateNadeuriApiModelCopyWithImpl(this._self, this._then);

  final _UpdateNadeuriApiModel _self;
  final $Res Function(_UpdateNadeuriApiModel) _then;

/// Create a copy of UpdateNadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(_UpdateNadeuriApiModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
