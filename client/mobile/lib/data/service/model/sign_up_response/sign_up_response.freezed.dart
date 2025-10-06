// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SignUpResponse _$SignUpResponseFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'registered':
          return Registered.fromJson(
            json
          );
                case 'validationError':
          return ValidationError.fromJson(
            json
          );
                case 'duplicateEmailError':
          return DuplicateEmailError.fromJson(
            json
          );
                case 'unknownError':
          return UnknownError.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SignUpResponse',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SignUpResponse {



  /// Serializes this SignUpResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpResponse);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpResponse()';
}


}

/// @nodoc
class $SignUpResponseCopyWith<$Res>  {
$SignUpResponseCopyWith(SignUpResponse _, $Res Function(SignUpResponse) __);
}


/// Adds pattern-matching-related methods to [SignUpResponse].
extension SignUpResponsePatterns on SignUpResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Registered value)?  registered,TResult Function( ValidationError value)?  validationError,TResult Function( DuplicateEmailError value)?  duplicateEmailError,TResult Function( UnknownError value)?  unknownError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Registered() when registered != null:
return registered(_that);case ValidationError() when validationError != null:
return validationError(_that);case DuplicateEmailError() when duplicateEmailError != null:
return duplicateEmailError(_that);case UnknownError() when unknownError != null:
return unknownError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Registered value)  registered,required TResult Function( ValidationError value)  validationError,required TResult Function( DuplicateEmailError value)  duplicateEmailError,required TResult Function( UnknownError value)  unknownError,}){
final _that = this;
switch (_that) {
case Registered():
return registered(_that);case ValidationError():
return validationError(_that);case DuplicateEmailError():
return duplicateEmailError(_that);case UnknownError():
return unknownError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Registered value)?  registered,TResult? Function( ValidationError value)?  validationError,TResult? Function( DuplicateEmailError value)?  duplicateEmailError,TResult? Function( UnknownError value)?  unknownError,}){
final _that = this;
switch (_that) {
case Registered() when registered != null:
return registered(_that);case ValidationError() when validationError != null:
return validationError(_that);case DuplicateEmailError() when duplicateEmailError != null:
return duplicateEmailError(_that);case UnknownError() when unknownError != null:
return unknownError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  registered,TResult Function( List<String>? email,  List<String>? password,  List<String>? nickname)?  validationError,TResult Function()?  duplicateEmailError,TResult Function()?  unknownError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Registered() when registered != null:
return registered();case ValidationError() when validationError != null:
return validationError(_that.email,_that.password,_that.nickname);case DuplicateEmailError() when duplicateEmailError != null:
return duplicateEmailError();case UnknownError() when unknownError != null:
return unknownError();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  registered,required TResult Function( List<String>? email,  List<String>? password,  List<String>? nickname)  validationError,required TResult Function()  duplicateEmailError,required TResult Function()  unknownError,}) {final _that = this;
switch (_that) {
case Registered():
return registered();case ValidationError():
return validationError(_that.email,_that.password,_that.nickname);case DuplicateEmailError():
return duplicateEmailError();case UnknownError():
return unknownError();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  registered,TResult? Function( List<String>? email,  List<String>? password,  List<String>? nickname)?  validationError,TResult? Function()?  duplicateEmailError,TResult? Function()?  unknownError,}) {final _that = this;
switch (_that) {
case Registered() when registered != null:
return registered();case ValidationError() when validationError != null:
return validationError(_that.email,_that.password,_that.nickname);case DuplicateEmailError() when duplicateEmailError != null:
return duplicateEmailError();case UnknownError() when unknownError != null:
return unknownError();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class Registered implements SignUpResponse {
  const Registered({final  String? $type}): $type = $type ?? 'registered';
  factory Registered.fromJson(Map<String, dynamic> json) => _$RegisteredFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$RegisteredToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Registered);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpResponse.registered()';
}


}




/// @nodoc
@JsonSerializable()

class ValidationError implements SignUpResponse {
  const ValidationError({required final  List<String>? email, required final  List<String>? password, required final  List<String>? nickname, final  String? $type}): _email = email,_password = password,_nickname = nickname,$type = $type ?? 'validationError';
  factory ValidationError.fromJson(Map<String, dynamic> json) => _$ValidationErrorFromJson(json);

 final  List<String>? _email;
 List<String>? get email {
  final value = _email;
  if (value == null) return null;
  if (_email is EqualUnmodifiableListView) return _email;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _password;
 List<String>? get password {
  final value = _password;
  if (value == null) return null;
  if (_password is EqualUnmodifiableListView) return _password;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _nickname;
 List<String>? get nickname {
  final value = _nickname;
  if (value == null) return null;
  if (_nickname is EqualUnmodifiableListView) return _nickname;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SignUpResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationErrorCopyWith<ValidationError> get copyWith => _$ValidationErrorCopyWithImpl<ValidationError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValidationErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationError&&const DeepCollectionEquality().equals(other._email, _email)&&const DeepCollectionEquality().equals(other._password, _password)&&const DeepCollectionEquality().equals(other._nickname, _nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_email),const DeepCollectionEquality().hash(_password),const DeepCollectionEquality().hash(_nickname));

@override
String toString() {
  return 'SignUpResponse.validationError(email: $email, password: $password, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $ValidationErrorCopyWith<$Res> implements $SignUpResponseCopyWith<$Res> {
  factory $ValidationErrorCopyWith(ValidationError value, $Res Function(ValidationError) _then) = _$ValidationErrorCopyWithImpl;
@useResult
$Res call({
 List<String>? email, List<String>? password, List<String>? nickname
});




}
/// @nodoc
class _$ValidationErrorCopyWithImpl<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  _$ValidationErrorCopyWithImpl(this._self, this._then);

  final ValidationError _self;
  final $Res Function(ValidationError) _then;

/// Create a copy of SignUpResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = freezed,Object? password = freezed,Object? nickname = freezed,}) {
  return _then(ValidationError(
email: freezed == email ? _self._email : email // ignore: cast_nullable_to_non_nullable
as List<String>?,password: freezed == password ? _self._password : password // ignore: cast_nullable_to_non_nullable
as List<String>?,nickname: freezed == nickname ? _self._nickname : nickname // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DuplicateEmailError implements SignUpResponse {
  const DuplicateEmailError({final  String? $type}): $type = $type ?? 'duplicateEmailError';
  factory DuplicateEmailError.fromJson(Map<String, dynamic> json) => _$DuplicateEmailErrorFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DuplicateEmailErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuplicateEmailError);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpResponse.duplicateEmailError()';
}


}




/// @nodoc
@JsonSerializable()

class UnknownError implements SignUpResponse {
  const UnknownError({final  String? $type}): $type = $type ?? 'unknownError';
  factory UnknownError.fromJson(Map<String, dynamic> json) => _$UnknownErrorFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UnknownErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownError);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpResponse.unknownError()';
}


}




// dart format on
