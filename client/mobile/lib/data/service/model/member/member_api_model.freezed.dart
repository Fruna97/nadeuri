// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberApiModel {

 String get uuid; String get email; String? get nickname; String? get profileImageUrl;
/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberApiModelCopyWith<MemberApiModel> get copyWith => _$MemberApiModelCopyWithImpl<MemberApiModel>(this as MemberApiModel, _$identity);

  /// Serializes this MemberApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.email, email) || other.email == email)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,email,nickname,profileImageUrl);

@override
String toString() {
  return 'MemberApiModel(uuid: $uuid, email: $email, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class $MemberApiModelCopyWith<$Res>  {
  factory $MemberApiModelCopyWith(MemberApiModel value, $Res Function(MemberApiModel) _then) = _$MemberApiModelCopyWithImpl;
@useResult
$Res call({
 String uuid, String email, String? nickname, String? profileImageUrl
});




}
/// @nodoc
class _$MemberApiModelCopyWithImpl<$Res>
    implements $MemberApiModelCopyWith<$Res> {
  _$MemberApiModelCopyWithImpl(this._self, this._then);

  final MemberApiModel _self;
  final $Res Function(MemberApiModel) _then;

/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = null,Object? email = null,Object? nickname = freezed,Object? profileImageUrl = freezed,}) {
  return _then(_self.copyWith(
uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemberApiModel].
extension MemberApiModelPatterns on MemberApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemberApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemberApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemberApiModel value)  $default,){
final _that = this;
switch (_that) {
case _MemberApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemberApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _MemberApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uuid,  String email,  String? nickname,  String? profileImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemberApiModel() when $default != null:
return $default(_that.uuid,_that.email,_that.nickname,_that.profileImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uuid,  String email,  String? nickname,  String? profileImageUrl)  $default,) {final _that = this;
switch (_that) {
case _MemberApiModel():
return $default(_that.uuid,_that.email,_that.nickname,_that.profileImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uuid,  String email,  String? nickname,  String? profileImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _MemberApiModel() when $default != null:
return $default(_that.uuid,_that.email,_that.nickname,_that.profileImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemberApiModel extends MemberApiModel {
  const _MemberApiModel({required this.uuid, required this.email, this.nickname, this.profileImageUrl}): super._();
  factory _MemberApiModel.fromJson(Map<String, dynamic> json) => _$MemberApiModelFromJson(json);

@override final  String uuid;
@override final  String email;
@override final  String? nickname;
@override final  String? profileImageUrl;

/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberApiModelCopyWith<_MemberApiModel> get copyWith => __$MemberApiModelCopyWithImpl<_MemberApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.email, email) || other.email == email)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,email,nickname,profileImageUrl);

@override
String toString() {
  return 'MemberApiModel(uuid: $uuid, email: $email, nickname: $nickname, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class _$MemberApiModelCopyWith<$Res> implements $MemberApiModelCopyWith<$Res> {
  factory _$MemberApiModelCopyWith(_MemberApiModel value, $Res Function(_MemberApiModel) _then) = __$MemberApiModelCopyWithImpl;
@override @useResult
$Res call({
 String uuid, String email, String? nickname, String? profileImageUrl
});




}
/// @nodoc
class __$MemberApiModelCopyWithImpl<$Res>
    implements _$MemberApiModelCopyWith<$Res> {
  __$MemberApiModelCopyWithImpl(this._self, this._then);

  final _MemberApiModel _self;
  final $Res Function(_MemberApiModel) _then;

/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = null,Object? email = null,Object? nickname = freezed,Object? profileImageUrl = freezed,}) {
  return _then(_MemberApiModel(
uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
