// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenApiModel {

 String? get accessToken; String? get refreshToken;
/// Create a copy of TokenApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenApiModelCopyWith<TokenApiModel> get copyWith => _$TokenApiModelCopyWithImpl<TokenApiModel>(this as TokenApiModel, _$identity);

  /// Serializes this TokenApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenApiModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'TokenApiModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $TokenApiModelCopyWith<$Res>  {
  factory $TokenApiModelCopyWith(TokenApiModel value, $Res Function(TokenApiModel) _then) = _$TokenApiModelCopyWithImpl;
@useResult
$Res call({
 String? accessToken, String? refreshToken
});




}
/// @nodoc
class _$TokenApiModelCopyWithImpl<$Res>
    implements $TokenApiModelCopyWith<$Res> {
  _$TokenApiModelCopyWithImpl(this._self, this._then);

  final TokenApiModel _self;
  final $Res Function(TokenApiModel) _then;

/// Create a copy of TokenApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,}) {
  return _then(_self.copyWith(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenApiModel].
extension TokenApiModelPatterns on TokenApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenApiModel value)  $default,){
final _that = this;
switch (_that) {
case _TokenApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _TokenApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? accessToken,  String? refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenApiModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? accessToken,  String? refreshToken)  $default,) {final _that = this;
switch (_that) {
case _TokenApiModel():
return $default(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? accessToken,  String? refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _TokenApiModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenApiModel implements TokenApiModel {
  const _TokenApiModel({this.accessToken, this.refreshToken});
  factory _TokenApiModel.fromJson(Map<String, dynamic> json) => _$TokenApiModelFromJson(json);

@override final  String? accessToken;
@override final  String? refreshToken;

/// Create a copy of TokenApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenApiModelCopyWith<_TokenApiModel> get copyWith => __$TokenApiModelCopyWithImpl<_TokenApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenApiModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'TokenApiModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$TokenApiModelCopyWith<$Res> implements $TokenApiModelCopyWith<$Res> {
  factory _$TokenApiModelCopyWith(_TokenApiModel value, $Res Function(_TokenApiModel) _then) = __$TokenApiModelCopyWithImpl;
@override @useResult
$Res call({
 String? accessToken, String? refreshToken
});




}
/// @nodoc
class __$TokenApiModelCopyWithImpl<$Res>
    implements _$TokenApiModelCopyWith<$Res> {
  __$TokenApiModelCopyWithImpl(this._self, this._then);

  final _TokenApiModel _self;
  final $Res Function(_TokenApiModel) _then;

/// Create a copy of TokenApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = freezed,Object? refreshToken = freezed,}) {
  return _then(_TokenApiModel(
accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
