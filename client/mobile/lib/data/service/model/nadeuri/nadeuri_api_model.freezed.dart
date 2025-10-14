// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nadeuri_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NadeuriApiModel {

 String? get title;
/// Create a copy of NadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NadeuriApiModelCopyWith<NadeuriApiModel> get copyWith => _$NadeuriApiModelCopyWithImpl<NadeuriApiModel>(this as NadeuriApiModel, _$identity);

  /// Serializes this NadeuriApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NadeuriApiModel&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'NadeuriApiModel(title: $title)';
}


}

/// @nodoc
abstract mixin class $NadeuriApiModelCopyWith<$Res>  {
  factory $NadeuriApiModelCopyWith(NadeuriApiModel value, $Res Function(NadeuriApiModel) _then) = _$NadeuriApiModelCopyWithImpl;
@useResult
$Res call({
 String? title
});




}
/// @nodoc
class _$NadeuriApiModelCopyWithImpl<$Res>
    implements $NadeuriApiModelCopyWith<$Res> {
  _$NadeuriApiModelCopyWithImpl(this._self, this._then);

  final NadeuriApiModel _self;
  final $Res Function(NadeuriApiModel) _then;

/// Create a copy of NadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NadeuriApiModel].
extension NadeuriApiModelPatterns on NadeuriApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NadeuriApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NadeuriApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NadeuriApiModel value)  $default,){
final _that = this;
switch (_that) {
case _NadeuriApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NadeuriApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _NadeuriApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NadeuriApiModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title)  $default,) {final _that = this;
switch (_that) {
case _NadeuriApiModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title)?  $default,) {final _that = this;
switch (_that) {
case _NadeuriApiModel() when $default != null:
return $default(_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NadeuriApiModel implements NadeuriApiModel {
  const _NadeuriApiModel({required this.title});
  factory _NadeuriApiModel.fromJson(Map<String, dynamic> json) => _$NadeuriApiModelFromJson(json);

@override final  String? title;

/// Create a copy of NadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NadeuriApiModelCopyWith<_NadeuriApiModel> get copyWith => __$NadeuriApiModelCopyWithImpl<_NadeuriApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NadeuriApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NadeuriApiModel&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'NadeuriApiModel(title: $title)';
}


}

/// @nodoc
abstract mixin class _$NadeuriApiModelCopyWith<$Res> implements $NadeuriApiModelCopyWith<$Res> {
  factory _$NadeuriApiModelCopyWith(_NadeuriApiModel value, $Res Function(_NadeuriApiModel) _then) = __$NadeuriApiModelCopyWithImpl;
@override @useResult
$Res call({
 String? title
});




}
/// @nodoc
class __$NadeuriApiModelCopyWithImpl<$Res>
    implements _$NadeuriApiModelCopyWith<$Res> {
  __$NadeuriApiModelCopyWithImpl(this._self, this._then);

  final _NadeuriApiModel _self;
  final $Res Function(_NadeuriApiModel) _then;

/// Create a copy of NadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,}) {
  return _then(_NadeuriApiModel(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
