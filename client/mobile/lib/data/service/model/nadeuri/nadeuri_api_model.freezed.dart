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

 String get uuid; String? get title; List<MemberApiModel>? get members;
/// Create a copy of NadeuriApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NadeuriApiModelCopyWith<NadeuriApiModel> get copyWith => _$NadeuriApiModelCopyWithImpl<NadeuriApiModel>(this as NadeuriApiModel, _$identity);

  /// Serializes this NadeuriApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NadeuriApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'NadeuriApiModel(uuid: $uuid, title: $title, members: $members)';
}


}

/// @nodoc
abstract mixin class $NadeuriApiModelCopyWith<$Res>  {
  factory $NadeuriApiModelCopyWith(NadeuriApiModel value, $Res Function(NadeuriApiModel) _then) = _$NadeuriApiModelCopyWithImpl;
@useResult
$Res call({
 String uuid, String? title, List<MemberApiModel>? members
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
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = null,Object? title = freezed,Object? members = freezed,}) {
  return _then(_self.copyWith(
uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<MemberApiModel>?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uuid,  String? title,  List<MemberApiModel>? members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NadeuriApiModel() when $default != null:
return $default(_that.uuid,_that.title,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uuid,  String? title,  List<MemberApiModel>? members)  $default,) {final _that = this;
switch (_that) {
case _NadeuriApiModel():
return $default(_that.uuid,_that.title,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uuid,  String? title,  List<MemberApiModel>? members)?  $default,) {final _that = this;
switch (_that) {
case _NadeuriApiModel() when $default != null:
return $default(_that.uuid,_that.title,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NadeuriApiModel extends NadeuriApiModel {
  const _NadeuriApiModel({required this.uuid, this.title, final  List<MemberApiModel>? members}): _members = members,super._();
  factory _NadeuriApiModel.fromJson(Map<String, dynamic> json) => _$NadeuriApiModelFromJson(json);

@override final  String uuid;
@override final  String? title;
 final  List<MemberApiModel>? _members;
@override List<MemberApiModel>? get members {
  final value = _members;
  if (value == null) return null;
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NadeuriApiModel&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'NadeuriApiModel(uuid: $uuid, title: $title, members: $members)';
}


}

/// @nodoc
abstract mixin class _$NadeuriApiModelCopyWith<$Res> implements $NadeuriApiModelCopyWith<$Res> {
  factory _$NadeuriApiModelCopyWith(_NadeuriApiModel value, $Res Function(_NadeuriApiModel) _then) = __$NadeuriApiModelCopyWithImpl;
@override @useResult
$Res call({
 String uuid, String? title, List<MemberApiModel>? members
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
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = null,Object? title = freezed,Object? members = freezed,}) {
  return _then(_NadeuriApiModel(
uuid: null == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,members: freezed == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<MemberApiModel>?,
  ));
}


}

// dart format on
