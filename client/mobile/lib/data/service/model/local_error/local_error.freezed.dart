// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalError {

 TokenType get tokenType;
/// Create a copy of LocalError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalErrorCopyWith<LocalError> get copyWith => _$LocalErrorCopyWithImpl<LocalError>(this as LocalError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalError&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}


@override
int get hashCode => Object.hash(runtimeType,tokenType);

@override
String toString() {
  return 'LocalError(tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class $LocalErrorCopyWith<$Res>  {
  factory $LocalErrorCopyWith(LocalError value, $Res Function(LocalError) _then) = _$LocalErrorCopyWithImpl;
@useResult
$Res call({
 TokenType tokenType
});




}
/// @nodoc
class _$LocalErrorCopyWithImpl<$Res>
    implements $LocalErrorCopyWith<$Res> {
  _$LocalErrorCopyWithImpl(this._self, this._then);

  final LocalError _self;
  final $Res Function(LocalError) _then;

/// Create a copy of LocalError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tokenType = null,}) {
  return _then(_self.copyWith(
tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as TokenType,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalError].
extension LocalErrorPatterns on LocalError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TokenNotFound value)?  tokenNotFound,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TokenNotFound() when tokenNotFound != null:
return tokenNotFound(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TokenNotFound value)  tokenNotFound,}){
final _that = this;
switch (_that) {
case TokenNotFound():
return tokenNotFound(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TokenNotFound value)?  tokenNotFound,}){
final _that = this;
switch (_that) {
case TokenNotFound() when tokenNotFound != null:
return tokenNotFound(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( TokenType tokenType)?  tokenNotFound,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TokenNotFound() when tokenNotFound != null:
return tokenNotFound(_that.tokenType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( TokenType tokenType)  tokenNotFound,}) {final _that = this;
switch (_that) {
case TokenNotFound():
return tokenNotFound(_that.tokenType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( TokenType tokenType)?  tokenNotFound,}) {final _that = this;
switch (_that) {
case TokenNotFound() when tokenNotFound != null:
return tokenNotFound(_that.tokenType);case _:
  return null;

}
}

}

/// @nodoc


class TokenNotFound implements LocalError {
  const TokenNotFound({required this.tokenType});
  

@override final  TokenType tokenType;

/// Create a copy of LocalError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenNotFoundCopyWith<TokenNotFound> get copyWith => _$TokenNotFoundCopyWithImpl<TokenNotFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenNotFound&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}


@override
int get hashCode => Object.hash(runtimeType,tokenType);

@override
String toString() {
  return 'LocalError.tokenNotFound(tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class $TokenNotFoundCopyWith<$Res> implements $LocalErrorCopyWith<$Res> {
  factory $TokenNotFoundCopyWith(TokenNotFound value, $Res Function(TokenNotFound) _then) = _$TokenNotFoundCopyWithImpl;
@override @useResult
$Res call({
 TokenType tokenType
});




}
/// @nodoc
class _$TokenNotFoundCopyWithImpl<$Res>
    implements $TokenNotFoundCopyWith<$Res> {
  _$TokenNotFoundCopyWithImpl(this._self, this._then);

  final TokenNotFound _self;
  final $Res Function(TokenNotFound) _then;

/// Create a copy of LocalError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tokenType = null,}) {
  return _then(TokenNotFound(
tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as TokenType,
  ));
}


}

// dart format on
