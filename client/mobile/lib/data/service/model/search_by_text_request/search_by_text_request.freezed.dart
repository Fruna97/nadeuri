// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_by_text_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchByTextRequest {

 String get textQuery; double? get latitude; double? get longitude;
/// Create a copy of SearchByTextRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchByTextRequestCopyWith<SearchByTextRequest> get copyWith => _$SearchByTextRequestCopyWithImpl<SearchByTextRequest>(this as SearchByTextRequest, _$identity);

  /// Serializes this SearchByTextRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchByTextRequest&&(identical(other.textQuery, textQuery) || other.textQuery == textQuery)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textQuery,latitude,longitude);

@override
String toString() {
  return 'SearchByTextRequest(textQuery: $textQuery, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $SearchByTextRequestCopyWith<$Res>  {
  factory $SearchByTextRequestCopyWith(SearchByTextRequest value, $Res Function(SearchByTextRequest) _then) = _$SearchByTextRequestCopyWithImpl;
@useResult
$Res call({
 String textQuery, double? latitude, double? longitude
});




}
/// @nodoc
class _$SearchByTextRequestCopyWithImpl<$Res>
    implements $SearchByTextRequestCopyWith<$Res> {
  _$SearchByTextRequestCopyWithImpl(this._self, this._then);

  final SearchByTextRequest _self;
  final $Res Function(SearchByTextRequest) _then;

/// Create a copy of SearchByTextRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textQuery = null,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
textQuery: null == textQuery ? _self.textQuery : textQuery // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchByTextRequest].
extension SearchByTextRequestPatterns on SearchByTextRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchByTextRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchByTextRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchByTextRequest value)  $default,){
final _that = this;
switch (_that) {
case _SearchByTextRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchByTextRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SearchByTextRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String textQuery,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchByTextRequest() when $default != null:
return $default(_that.textQuery,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String textQuery,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _SearchByTextRequest():
return $default(_that.textQuery,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String textQuery,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _SearchByTextRequest() when $default != null:
return $default(_that.textQuery,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createFactory: false)

class _SearchByTextRequest implements SearchByTextRequest {
  const _SearchByTextRequest({required this.textQuery, this.latitude, this.longitude});
  

@override final  String textQuery;
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of SearchByTextRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchByTextRequestCopyWith<_SearchByTextRequest> get copyWith => __$SearchByTextRequestCopyWithImpl<_SearchByTextRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchByTextRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchByTextRequest&&(identical(other.textQuery, textQuery) || other.textQuery == textQuery)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textQuery,latitude,longitude);

@override
String toString() {
  return 'SearchByTextRequest(textQuery: $textQuery, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$SearchByTextRequestCopyWith<$Res> implements $SearchByTextRequestCopyWith<$Res> {
  factory _$SearchByTextRequestCopyWith(_SearchByTextRequest value, $Res Function(_SearchByTextRequest) _then) = __$SearchByTextRequestCopyWithImpl;
@override @useResult
$Res call({
 String textQuery, double? latitude, double? longitude
});




}
/// @nodoc
class __$SearchByTextRequestCopyWithImpl<$Res>
    implements _$SearchByTextRequestCopyWith<$Res> {
  __$SearchByTextRequestCopyWithImpl(this._self, this._then);

  final _SearchByTextRequest _self;
  final $Res Function(_SearchByTextRequest) _then;

/// Create a copy of SearchByTextRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textQuery = null,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_SearchByTextRequest(
textQuery: null == textQuery ? _self.textQuery : textQuery // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
