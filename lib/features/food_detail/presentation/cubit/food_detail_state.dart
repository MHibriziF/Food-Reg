part of '_cubits.dart';

enum SectionStatus { loading, success, empty, failure }

@freezed
abstract class FoodDetailState with _$FoodDetailState {
  const factory FoodDetailState({
    required SectionStatus mealStatus,
    MealInfo? meal,
    required SectionStatus nutritionStatus,
    NutritionInfo? nutrition,
  }) = _FoodDetailState;

  factory FoodDetailState.initial() => const FoodDetailState(
    mealStatus: SectionStatus.loading,
    nutritionStatus: SectionStatus.loading,
  );
}
