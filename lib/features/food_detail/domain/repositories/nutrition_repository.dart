part of '_repositories.dart';

abstract class NutritionRepository {
  Future<Either<Failure, NutritionInfo>> getNutrition(String foodName);
}
