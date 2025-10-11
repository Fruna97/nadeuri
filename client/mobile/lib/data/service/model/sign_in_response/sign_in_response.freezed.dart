// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SignInResponse _$SignInResponseFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'authenticated':
          return Authenticated.fromJson(
            json
          );
                case 'unAuthorized':
          return UnAuthorized.fromJson(
            json
          );
                case 'requestTimeoutError':
          return RequestTimeout.fromJson(
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
  'SignInResponse',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SignInResponse {



  /// Serializes this SignInResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInResponse);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInResponse()';
}


}

/// @nodoc
class $SignInResponseCopyWith<$Res>  {
$SignInResponseCopyWith(SignInResponse _, $Res Function(SignInResponse) __);
}


/// Adds pattern-matching-related methods to [SignInResponse].
extension SignInResponsePatterns on SignInResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Authenticated value)?  authenticated,TResult Function( UnAuthorized value)?  unAuthorized,TResult Function( RequestTimeout value)?  requestTimeoutError,TResult Function( ValidationError value)?  validationError,TResult Function( UnknownError value)?  unknownError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Authenticated() when authenticated != null:
return authenticated(_that);case UnAuthorized() when unAuthorized != null:
return unAuthorized(_that);case RequestTimeout() when requestTimeoutError != null:
return requestTimeoutError(_that);case ValidationError() when validationError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Authenticated value)  authenticated,required TResult Function( UnAuthorized value)  unAuthorized,required TResult Function( RequestTimeout value)  requestTimeoutError,required TResult Function( ValidationError value)  validationError,required TResult Function( UnknownError value)  unknownError,}){
final _that = this;
switch (_that) {
case Authenticated():
return authenticated(_that);case UnAuthorized():
return unAuthorized(_that);case RequestTimeout():
return requestTimeoutError(_that);case ValidationError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Authenticated value)?  authenticated,TResult? Function( UnAuthorized value)?  unAuthorized,TResult? Function( RequestTimeout value)?  requestTimeoutError,TResult? Function( ValidationError value)?  validationError,TResult? Function( UnknownError value)?  unknownError,}){
final _that = this;
switch (_that) {
case Authenticated() when authenticated != null:
return authenticated(_that);case UnAuthorized() when unAuthorized != null:
return unAuthorized(_that);case RequestTimeout() when requestTimeoutError != null:
return requestTimeoutError(_that);case ValidationError() when validationError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String accessToken,  String refreshToken)?  authenticated,TResult Function()?  unAuthorized,TResult Function()?  requestTimeoutError,TResult Function( List<String>? email,  List<String>? password)?  validationError,TResult Function()?  unknownError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Authenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.refreshToken);case UnAuthorized() when unAuthorized != null:
return unAuthorized();case RequestTimeout() when requestTimeoutError != null:
return requestTimeoutError();case ValidationError() when validationError != null:
return validationError(_that.email,_that.password);case UnknownError() when unknownError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String accessToken,  String refreshToken)  authenticated,required TResult Function()  unAuthorized,required TResult Function()  requestTimeoutError,required TResult Function( List<String>? email,  List<String>? password)  validationError,required TResult Function()  unknownError,}) {final _that = this;
switch (_that) {
case Authenticated():
return authenticated(_that.accessToken,_that.refreshToken);case UnAuthorized():
return unAuthorized();case RequestTimeout():
return requestTimeoutError();case ValidationError():
return validationError(_that.email,_that.password);case UnknownError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String accessToken,  String refreshToken)?  authenticated,TResult? Function()?  unAuthorized,TResult? Function()?  requestTimeoutError,TResult? Function( List<String>? email,  List<String>? password)?  validationError,TResult? Function()?  unknownError,}) {final _that = this;
switch (_that) {
case Authenticated() when authenticated != null:
return authenticated(_that.accessToken,_that.refreshToken);case UnAuthorized() when unAuthorized != null:
return unAuthorized();case RequestTimeout() when requestTimeoutError != null:
return requestTimeoutError();case ValidationError() when validationError != null:
return validationError(_that.email,_that.password);case UnknownError() when unknownError != null:
return unknownError();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class Authenticated implements SignInResponse {
  const Authenticated({required this.accessToken, required this.refreshToken, final  String? $type}): $type = $type ?? 'authenticated';
  factory Authenticated.fromJson(Map<String, dynamic> json) => _$AuthenticatedFromJson(json);

 final  String accessToken;
 final  String refreshToken;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SignInResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticatedCopyWith<Authenticated> get copyWith => _$AuthenticatedCopyWithImpl<Authenticated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthenticatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Authenticated&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'SignInResponse.authenticated(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $AuthenticatedCopyWith<$Res> implements $SignInResponseCopyWith<$Res> {
  factory $AuthenticatedCopyWith(Authenticated value, $Res Function(Authenticated) _then) = _$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken
});




}
/// @nodoc
class _$AuthenticatedCopyWithImpl<$Res>
    implements $AuthenticatedCopyWith<$Res> {
  _$AuthenticatedCopyWithImpl(this._self, this._then);

  final Authenticated _self;
  final $Res Function(Authenticated) _then;

/// Create a copy of SignInResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(Authenticated(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnAuthorized implements SignInResponse {
  const UnAuthorized({final  String? $type}): $type = $type ?? 'unAuthorized';
  factory UnAuthorized.fromJson(Map<String, dynamic> json) => _$UnAuthorizedFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UnAuthorizedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnAuthorized);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInResponse.unAuthorized()';
}


}




/// @nodoc
@JsonSerializable()

class RequestTimeout implements SignInResponse {
  const RequestTimeout({final  String? $type}): $type = $type ?? 'requestTimeoutError';
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
  return 'SignInResponse.requestTimeoutError()';
}


}




/// @nodoc
@JsonSerializable()

class ValidationError implements SignInResponse {
  const ValidationError({required final  List<String>? email, required final  List<String>? password, final  String? $type}): _email = email,_password = password,$type = $type ?? 'validationError';
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


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SignInResponse
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationError&&const DeepCollectionEquality().equals(other._email, _email)&&const DeepCollectionEquality().equals(other._password, _password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_email),const DeepCollectionEquality().hash(_password));

@override
String toString() {
  return 'SignInResponse.validationError(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $ValidationErrorCopyWith<$Res> implements $SignInResponseCopyWith<$Res> {
  factory $ValidationErrorCopyWith(ValidationError value, $Res Function(ValidationError) _then) = _$ValidationErrorCopyWithImpl;
@useResult
$Res call({
 List<String>? email, List<String>? password
});




}
/// @nodoc
class _$ValidationErrorCopyWithImpl<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  _$ValidationErrorCopyWithImpl(this._self, this._then);

  final ValidationError _self;
  final $Res Function(ValidationError) _then;

/// Create a copy of SignInResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = freezed,Object? password = freezed,}) {
  return _then(ValidationError(
email: freezed == email ? _self._email : email // ignore: cast_nullable_to_non_nullable
as List<String>?,password: freezed == password ? _self._password : password // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnknownError implements SignInResponse {
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
  return 'SignInResponse.unknownError()';
}


}




// dart format on
