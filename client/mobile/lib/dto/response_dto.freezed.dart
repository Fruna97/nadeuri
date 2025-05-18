// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResponseDto<T> {

 String get message; T? get data;
/// Create a copy of ResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResponseDtoCopyWith<T, ResponseDto<T>> get copyWith => _$ResponseDtoCopyWithImpl<T, ResponseDto<T>>(this as ResponseDto<T>, _$identity);

  /// Serializes this ResponseDto to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResponseDto<T>&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ResponseDto<$T>(message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ResponseDtoCopyWith<T,$Res>  {
  factory $ResponseDtoCopyWith(ResponseDto<T> value, $Res Function(ResponseDto<T>) _then) = _$ResponseDtoCopyWithImpl;
@useResult
$Res call({
 String message, T? data
});




}
/// @nodoc
class _$ResponseDtoCopyWithImpl<T,$Res>
    implements $ResponseDtoCopyWith<T, $Res> {
  _$ResponseDtoCopyWithImpl(this._self, this._then);

  final ResponseDto<T> _self;
  final $Res Function(ResponseDto<T>) _then;

/// Create a copy of ResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}

}


/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _ResponseDto<T> implements ResponseDto<T> {
  const _ResponseDto({required this.message, this.data});
  factory _ResponseDto.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$ResponseDtoFromJson(json,fromJsonT);

@override final  String message;
@override final  T? data;

/// Create a copy of ResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResponseDtoCopyWith<T, _ResponseDto<T>> get copyWith => __$ResponseDtoCopyWithImpl<T, _ResponseDto<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$ResponseDtoToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResponseDto<T>&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ResponseDto<$T>(message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ResponseDtoCopyWith<T,$Res> implements $ResponseDtoCopyWith<T, $Res> {
  factory _$ResponseDtoCopyWith(_ResponseDto<T> value, $Res Function(_ResponseDto<T>) _then) = __$ResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String message, T? data
});




}
/// @nodoc
class __$ResponseDtoCopyWithImpl<T,$Res>
    implements _$ResponseDtoCopyWith<T, $Res> {
  __$ResponseDtoCopyWithImpl(this._self, this._then);

  final _ResponseDto<T> _self;
  final $Res Function(_ResponseDto<T>) _then;

/// Create a copy of ResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? data = freezed,}) {
  return _then(_ResponseDto<T>(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}


}

// dart format on
