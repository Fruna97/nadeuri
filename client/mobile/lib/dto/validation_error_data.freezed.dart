// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_error_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ValidationErrorData {

 List<String>? get email; List<String>? get password; List<String>? get nickname;
/// Create a copy of ValidationErrorData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationErrorDataCopyWith<ValidationErrorData> get copyWith => _$ValidationErrorDataCopyWithImpl<ValidationErrorData>(this as ValidationErrorData, _$identity);

  /// Serializes this ValidationErrorData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationErrorData&&const DeepCollectionEquality().equals(other.email, email)&&const DeepCollectionEquality().equals(other.password, password)&&const DeepCollectionEquality().equals(other.nickname, nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(email),const DeepCollectionEquality().hash(password),const DeepCollectionEquality().hash(nickname));

@override
String toString() {
  return 'ValidationErrorData(email: $email, password: $password, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $ValidationErrorDataCopyWith<$Res>  {
  factory $ValidationErrorDataCopyWith(ValidationErrorData value, $Res Function(ValidationErrorData) _then) = _$ValidationErrorDataCopyWithImpl;
@useResult
$Res call({
 List<String>? email, List<String>? password, List<String>? nickname
});




}
/// @nodoc
class _$ValidationErrorDataCopyWithImpl<$Res>
    implements $ValidationErrorDataCopyWith<$Res> {
  _$ValidationErrorDataCopyWithImpl(this._self, this._then);

  final ValidationErrorData _self;
  final $Res Function(ValidationErrorData) _then;

/// Create a copy of ValidationErrorData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = freezed,Object? password = freezed,Object? nickname = freezed,}) {
  return _then(_self.copyWith(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as List<String>?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as List<String>?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidationErrorData].
extension ValidationErrorDataPatterns on ValidationErrorData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ValidationErrorData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ValidationErrorData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ValidationErrorData value)  $default,){
final _that = this;
switch (_that) {
case _ValidationErrorData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ValidationErrorData value)?  $default,){
final _that = this;
switch (_that) {
case _ValidationErrorData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String>? email,  List<String>? password,  List<String>? nickname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidationErrorData() when $default != null:
return $default(_that.email,_that.password,_that.nickname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String>? email,  List<String>? password,  List<String>? nickname)  $default,) {final _that = this;
switch (_that) {
case _ValidationErrorData():
return $default(_that.email,_that.password,_that.nickname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String>? email,  List<String>? password,  List<String>? nickname)?  $default,) {final _that = this;
switch (_that) {
case _ValidationErrorData() when $default != null:
return $default(_that.email,_that.password,_that.nickname);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ValidationErrorData implements ValidationErrorData {
  const _ValidationErrorData({final  List<String>? email, final  List<String>? password, final  List<String>? nickname}): _email = email,_password = password,_nickname = nickname;
  factory _ValidationErrorData.fromJson(Map<String, dynamic> json) => _$ValidationErrorDataFromJson(json);

 final  List<String>? _email;
@override List<String>? get email {
  final value = _email;
  if (value == null) return null;
  if (_email is EqualUnmodifiableListView) return _email;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _password;
@override List<String>? get password {
  final value = _password;
  if (value == null) return null;
  if (_password is EqualUnmodifiableListView) return _password;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _nickname;
@override List<String>? get nickname {
  final value = _nickname;
  if (value == null) return null;
  if (_nickname is EqualUnmodifiableListView) return _nickname;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ValidationErrorData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidationErrorDataCopyWith<_ValidationErrorData> get copyWith => __$ValidationErrorDataCopyWithImpl<_ValidationErrorData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValidationErrorDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidationErrorData&&const DeepCollectionEquality().equals(other._email, _email)&&const DeepCollectionEquality().equals(other._password, _password)&&const DeepCollectionEquality().equals(other._nickname, _nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_email),const DeepCollectionEquality().hash(_password),const DeepCollectionEquality().hash(_nickname));

@override
String toString() {
  return 'ValidationErrorData(email: $email, password: $password, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class _$ValidationErrorDataCopyWith<$Res> implements $ValidationErrorDataCopyWith<$Res> {
  factory _$ValidationErrorDataCopyWith(_ValidationErrorData value, $Res Function(_ValidationErrorData) _then) = __$ValidationErrorDataCopyWithImpl;
@override @useResult
$Res call({
 List<String>? email, List<String>? password, List<String>? nickname
});




}
/// @nodoc
class __$ValidationErrorDataCopyWithImpl<$Res>
    implements _$ValidationErrorDataCopyWith<$Res> {
  __$ValidationErrorDataCopyWithImpl(this._self, this._then);

  final _ValidationErrorData _self;
  final $Res Function(_ValidationErrorData) _then;

/// Create a copy of ValidationErrorData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = freezed,Object? password = freezed,Object? nickname = freezed,}) {
  return _then(_ValidationErrorData(
email: freezed == email ? _self._email : email // ignore: cast_nullable_to_non_nullable
as List<String>?,password: freezed == password ? _self._password : password // ignore: cast_nullable_to_non_nullable
as List<String>?,nickname: freezed == nickname ? _self._nickname : nickname // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
