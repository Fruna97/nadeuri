// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nadeuri.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Nadeuri {

 String? get uuid; String get title; List<Member> get members; List<Plan> get plans;
/// Create a copy of Nadeuri
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NadeuriCopyWith<Nadeuri> get copyWith => _$NadeuriCopyWithImpl<Nadeuri>(this as Nadeuri, _$identity);

  /// Serializes this Nadeuri to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Nadeuri&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.members, members)&&const DeepCollectionEquality().equals(other.plans, plans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,const DeepCollectionEquality().hash(members),const DeepCollectionEquality().hash(plans));

@override
String toString() {
  return 'Nadeuri(uuid: $uuid, title: $title, members: $members, plans: $plans)';
}


}

/// @nodoc
abstract mixin class $NadeuriCopyWith<$Res>  {
  factory $NadeuriCopyWith(Nadeuri value, $Res Function(Nadeuri) _then) = _$NadeuriCopyWithImpl;
@useResult
$Res call({
 String? uuid, String title, List<Member> members, List<Plan> plans
});




}
/// @nodoc
class _$NadeuriCopyWithImpl<$Res>
    implements $NadeuriCopyWith<$Res> {
  _$NadeuriCopyWithImpl(this._self, this._then);

  final Nadeuri _self;
  final $Res Function(Nadeuri) _then;

/// Create a copy of Nadeuri
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uuid = freezed,Object? title = null,Object? members = null,Object? plans = null,}) {
  return _then(_self.copyWith(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<Member>,plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as List<Plan>,
  ));
}

}


/// Adds pattern-matching-related methods to [Nadeuri].
extension NadeuriPatterns on Nadeuri {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Nadeuri value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Nadeuri() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Nadeuri value)  $default,){
final _that = this;
switch (_that) {
case _Nadeuri():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Nadeuri value)?  $default,){
final _that = this;
switch (_that) {
case _Nadeuri() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? uuid,  String title,  List<Member> members,  List<Plan> plans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Nadeuri() when $default != null:
return $default(_that.uuid,_that.title,_that.members,_that.plans);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? uuid,  String title,  List<Member> members,  List<Plan> plans)  $default,) {final _that = this;
switch (_that) {
case _Nadeuri():
return $default(_that.uuid,_that.title,_that.members,_that.plans);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? uuid,  String title,  List<Member> members,  List<Plan> plans)?  $default,) {final _that = this;
switch (_that) {
case _Nadeuri() when $default != null:
return $default(_that.uuid,_that.title,_that.members,_that.plans);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Nadeuri implements Nadeuri {
  const _Nadeuri({this.uuid, required this.title, required final  List<Member> members, required final  List<Plan> plans}): _members = members,_plans = plans;
  factory _Nadeuri.fromJson(Map<String, dynamic> json) => _$NadeuriFromJson(json);

@override final  String? uuid;
@override final  String title;
 final  List<Member> _members;
@override List<Member> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  List<Plan> _plans;
@override List<Plan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}


/// Create a copy of Nadeuri
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NadeuriCopyWith<_Nadeuri> get copyWith => __$NadeuriCopyWithImpl<_Nadeuri>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NadeuriToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Nadeuri&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._members, _members)&&const DeepCollectionEquality().equals(other._plans, _plans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uuid,title,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_plans));

@override
String toString() {
  return 'Nadeuri(uuid: $uuid, title: $title, members: $members, plans: $plans)';
}


}

/// @nodoc
abstract mixin class _$NadeuriCopyWith<$Res> implements $NadeuriCopyWith<$Res> {
  factory _$NadeuriCopyWith(_Nadeuri value, $Res Function(_Nadeuri) _then) = __$NadeuriCopyWithImpl;
@override @useResult
$Res call({
 String? uuid, String title, List<Member> members, List<Plan> plans
});




}
/// @nodoc
class __$NadeuriCopyWithImpl<$Res>
    implements _$NadeuriCopyWith<$Res> {
  __$NadeuriCopyWithImpl(this._self, this._then);

  final _Nadeuri _self;
  final $Res Function(_Nadeuri) _then;

/// Create a copy of Nadeuri
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uuid = freezed,Object? title = null,Object? members = null,Object? plans = null,}) {
  return _then(_Nadeuri(
uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<Member>,plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<Plan>,
  ));
}


}

// dart format on
