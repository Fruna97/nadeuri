// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ApiError _$ApiErrorFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'unauthorized':
          return Unauthorized.fromJson(
            json
          );
                case 'requestTimeout':
          return RequestTimeout.fromJson(
            json
          );
                case 'duplicateEmail':
          return DuplicateEmail.fromJson(
            json
          );
                case 'validationError':
          return ValidationError.fromJson(
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
  'ApiError',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$ApiError {



  /// Serializes this ApiError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiError);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiError()';
}


}

/// @nodoc
class $ApiErrorCopyWith<$Res>  {
$ApiErrorCopyWith(ApiError _, $Res Function(ApiError) __);
}


/// Adds pattern-matching-related methods to [ApiError].
extension ApiErrorPatterns on ApiError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Unauthorized value)?  unauthorized,TResult Function( RequestTimeout value)?  requestTimeout,TResult Function( DuplicateEmail value)?  duplicateEmail,TResult Function( ValidationError value)?  validationError,TResult Function( UnknownError value)?  unknownError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Unauthorized() when unauthorized != null:
return unauthorized(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case DuplicateEmail() when duplicateEmail != null:
return duplicateEmail(_that);case ValidationError() when validationError != null:
return validationError(_that);case UnknownError() when unknownError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Unauthorized value)  unauthorized,required TResult Function( RequestTimeout value)  requestTimeout,required TResult Function( DuplicateEmail value)  duplicateEmail,required TResult Function( ValidationError value)  validationError,required TResult Function( UnknownError value)  unknownError,}){
final _that = this;
switch (_that) {
case Unauthorized():
return unauthorized(_that);case RequestTimeout():
return requestTimeout(_that);case DuplicateEmail():
return duplicateEmail(_that);case ValidationError():
return validationError(_that);case UnknownError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Unauthorized value)?  unauthorized,TResult? Function( RequestTimeout value)?  requestTimeout,TResult? Function( DuplicateEmail value)?  duplicateEmail,TResult? Function( ValidationError value)?  validationError,TResult? Function( UnknownError value)?  unknownError,}){
final _that = this;
switch (_that) {
case Unauthorized() when unauthorized != null:
return unauthorized(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case DuplicateEmail() when duplicateEmail != null:
return duplicateEmail(_that);case ValidationError() when validationError != null:
return validationError(_that);case UnknownError() when unknownError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unauthorized,TResult Function()?  requestTimeout,TResult Function()?  duplicateEmail,TResult Function( List<String>? email,  List<String>? password,  List<String>? nickname)?  validationError,TResult Function()?  unknownError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Unauthorized() when unauthorized != null:
return unauthorized();case RequestTimeout() when requestTimeout != null:
return requestTimeout();case DuplicateEmail() when duplicateEmail != null:
return duplicateEmail();case ValidationError() when validationError != null:
return validationError(_that.email,_that.password,_that.nickname);case UnknownError() when unknownError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unauthorized,required TResult Function()  requestTimeout,required TResult Function()  duplicateEmail,required TResult Function( List<String>? email,  List<String>? password,  List<String>? nickname)  validationError,required TResult Function()  unknownError,}) {final _that = this;
switch (_that) {
case Unauthorized():
return unauthorized();case RequestTimeout():
return requestTimeout();case DuplicateEmail():
return duplicateEmail();case ValidationError():
return validationError(_that.email,_that.password,_that.nickname);case UnknownError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unauthorized,TResult? Function()?  requestTimeout,TResult? Function()?  duplicateEmail,TResult? Function( List<String>? email,  List<String>? password,  List<String>? nickname)?  validationError,TResult? Function()?  unknownError,}) {final _that = this;
switch (_that) {
case Unauthorized() when unauthorized != null:
return unauthorized();case RequestTimeout() when requestTimeout != null:
return requestTimeout();case DuplicateEmail() when duplicateEmail != null:
return duplicateEmail();case ValidationError() when validationError != null:
return validationError(_that.email,_that.password,_that.nickname);case UnknownError() when unknownError != null:
return unknownError();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class Unauthorized implements ApiError {
  const Unauthorized({final  String? $type}): $type = $type ?? 'unauthorized';
  factory Unauthorized.fromJson(Map<String, dynamic> json) => _$UnauthorizedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UnauthorizedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unauthorized);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiError.unauthorized()';
}


}




/// @nodoc
@JsonSerializable()

class RequestTimeout implements ApiError {
  const RequestTimeout({final  String? $type}): $type = $type ?? 'requestTimeout';
  factory RequestTimeout.fromJson(Map<String, dynamic> json) => _$RequestTimeoutFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$RequestTimeoutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestTimeout);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiError.requestTimeout()';
}


}




/// @nodoc
@JsonSerializable()

class DuplicateEmail implements ApiError {
  const DuplicateEmail({final  String? $type}): $type = $type ?? 'duplicateEmail';
  factory DuplicateEmail.fromJson(Map<String, dynamic> json) => _$DuplicateEmailFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$DuplicateEmailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuplicateEmail);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiError.duplicateEmail()';
}


}




/// @nodoc
@JsonSerializable()

class ValidationError implements ApiError {
  const ValidationError({final  List<String>? email, final  List<String>? password, final  List<String>? nickname, final  String? $type}): _email = email,_password = password,_nickname = nickname,$type = $type ?? 'validationError';
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


/// Create a copy of ApiError
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
  return 'ApiError.validationError(email: $email, password: $password, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $ValidationErrorCopyWith<$Res> implements $ApiErrorCopyWith<$Res> {
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

/// Create a copy of ApiError
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

class UnknownError implements ApiError {
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
  return 'ApiError.unknownError()';
}


}




// dart format on
