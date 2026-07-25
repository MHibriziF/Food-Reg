// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '_cubits.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FoodDetailState {

 SectionStatus get mealStatus; MealInfo? get meal; SectionStatus get nutritionStatus; NutritionInfo? get nutrition;
/// Create a copy of FoodDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodDetailStateCopyWith<FoodDetailState> get copyWith => _$FoodDetailStateCopyWithImpl<FoodDetailState>(this as FoodDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodDetailState&&(identical(other.mealStatus, mealStatus) || other.mealStatus == mealStatus)&&(identical(other.meal, meal) || other.meal == meal)&&(identical(other.nutritionStatus, nutritionStatus) || other.nutritionStatus == nutritionStatus)&&(identical(other.nutrition, nutrition) || other.nutrition == nutrition));
}


@override
int get hashCode => Object.hash(runtimeType,mealStatus,meal,nutritionStatus,nutrition);

@override
String toString() {
  return 'FoodDetailState(mealStatus: $mealStatus, meal: $meal, nutritionStatus: $nutritionStatus, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class $FoodDetailStateCopyWith<$Res>  {
  factory $FoodDetailStateCopyWith(FoodDetailState value, $Res Function(FoodDetailState) _then) = _$FoodDetailStateCopyWithImpl;
@useResult
$Res call({
 SectionStatus mealStatus, MealInfo? meal, SectionStatus nutritionStatus, NutritionInfo? nutrition
});




}
/// @nodoc
class _$FoodDetailStateCopyWithImpl<$Res>
    implements $FoodDetailStateCopyWith<$Res> {
  _$FoodDetailStateCopyWithImpl(this._self, this._then);

  final FoodDetailState _self;
  final $Res Function(FoodDetailState) _then;

/// Create a copy of FoodDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mealStatus = null,Object? meal = freezed,Object? nutritionStatus = null,Object? nutrition = freezed,}) {
  return _then(_self.copyWith(
mealStatus: null == mealStatus ? _self.mealStatus : mealStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,meal: freezed == meal ? _self.meal : meal // ignore: cast_nullable_to_non_nullable
as MealInfo?,nutritionStatus: null == nutritionStatus ? _self.nutritionStatus : nutritionStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,nutrition: freezed == nutrition ? _self.nutrition : nutrition // ignore: cast_nullable_to_non_nullable
as NutritionInfo?,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodDetailState].
extension FoodDetailStatePatterns on FoodDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodDetailState value)  $default,){
final _that = this;
switch (_that) {
case _FoodDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _FoodDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SectionStatus mealStatus,  MealInfo? meal,  SectionStatus nutritionStatus,  NutritionInfo? nutrition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodDetailState() when $default != null:
return $default(_that.mealStatus,_that.meal,_that.nutritionStatus,_that.nutrition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SectionStatus mealStatus,  MealInfo? meal,  SectionStatus nutritionStatus,  NutritionInfo? nutrition)  $default,) {final _that = this;
switch (_that) {
case _FoodDetailState():
return $default(_that.mealStatus,_that.meal,_that.nutritionStatus,_that.nutrition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SectionStatus mealStatus,  MealInfo? meal,  SectionStatus nutritionStatus,  NutritionInfo? nutrition)?  $default,) {final _that = this;
switch (_that) {
case _FoodDetailState() when $default != null:
return $default(_that.mealStatus,_that.meal,_that.nutritionStatus,_that.nutrition);case _:
  return null;

}
}

}

/// @nodoc


class _FoodDetailState implements FoodDetailState {
  const _FoodDetailState({required this.mealStatus, this.meal, required this.nutritionStatus, this.nutrition});
  

@override final  SectionStatus mealStatus;
@override final  MealInfo? meal;
@override final  SectionStatus nutritionStatus;
@override final  NutritionInfo? nutrition;

/// Create a copy of FoodDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodDetailStateCopyWith<_FoodDetailState> get copyWith => __$FoodDetailStateCopyWithImpl<_FoodDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodDetailState&&(identical(other.mealStatus, mealStatus) || other.mealStatus == mealStatus)&&(identical(other.meal, meal) || other.meal == meal)&&(identical(other.nutritionStatus, nutritionStatus) || other.nutritionStatus == nutritionStatus)&&(identical(other.nutrition, nutrition) || other.nutrition == nutrition));
}


@override
int get hashCode => Object.hash(runtimeType,mealStatus,meal,nutritionStatus,nutrition);

@override
String toString() {
  return 'FoodDetailState(mealStatus: $mealStatus, meal: $meal, nutritionStatus: $nutritionStatus, nutrition: $nutrition)';
}


}

/// @nodoc
abstract mixin class _$FoodDetailStateCopyWith<$Res> implements $FoodDetailStateCopyWith<$Res> {
  factory _$FoodDetailStateCopyWith(_FoodDetailState value, $Res Function(_FoodDetailState) _then) = __$FoodDetailStateCopyWithImpl;
@override @useResult
$Res call({
 SectionStatus mealStatus, MealInfo? meal, SectionStatus nutritionStatus, NutritionInfo? nutrition
});




}
/// @nodoc
class __$FoodDetailStateCopyWithImpl<$Res>
    implements _$FoodDetailStateCopyWith<$Res> {
  __$FoodDetailStateCopyWithImpl(this._self, this._then);

  final _FoodDetailState _self;
  final $Res Function(_FoodDetailState) _then;

/// Create a copy of FoodDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mealStatus = null,Object? meal = freezed,Object? nutritionStatus = null,Object? nutrition = freezed,}) {
  return _then(_FoodDetailState(
mealStatus: null == mealStatus ? _self.mealStatus : mealStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,meal: freezed == meal ? _self.meal : meal // ignore: cast_nullable_to_non_nullable
as MealInfo?,nutritionStatus: null == nutritionStatus ? _self.nutritionStatus : nutritionStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,nutrition: freezed == nutrition ? _self.nutrition : nutrition // ignore: cast_nullable_to_non_nullable
as NutritionInfo?,
  ));
}


}

// dart format on
