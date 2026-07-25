part of '_cubits.dart';

@injectable
class FoodDetailCubit extends Cubit<FoodDetailState> {
  final MealRepository _mealRepository;
  final NutritionRepository _nutritionRepository;

  FoodDetailCubit(this._mealRepository, this._nutritionRepository)
    : super(FoodDetailState.initial());

  Future<void> load(String foodName) async {
    emit(FoodDetailState.initial());
    await Future.wait([_loadMeal(foodName), _loadNutrition(foodName)]);
  }

  Future<void> _loadMeal(String foodName) async {
    final result = await _mealRepository.searchByName(foodName);
    result.fold(
      (failure) => emit(state.copyWith(mealStatus: SectionStatus.failure)),
      (meal) => emit(
        state.copyWith(
          mealStatus: meal == null ? SectionStatus.empty : SectionStatus.success,
          meal: meal,
        ),
      ),
    );
  }

  Future<void> _loadNutrition(String foodName) async {
    final result = await _nutritionRepository.getNutrition(foodName);
    result.fold(
      (failure) =>
          emit(state.copyWith(nutritionStatus: SectionStatus.failure)),
      (nutrition) => emit(
        state.copyWith(
          nutritionStatus: SectionStatus.success,
          nutrition: nutrition,
        ),
      ),
    );
  }
}
