part of '_repositories.dart';

abstract class MealRepository {
  /// Right(null) means no MealDB recipe matched this name.
  Future<Either<Failure, MealInfo?>> searchByName(String name);
}
