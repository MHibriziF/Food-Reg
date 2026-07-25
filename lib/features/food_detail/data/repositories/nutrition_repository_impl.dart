part of '_repositories.dart';

@LazySingleton(as: NutritionRepository)
class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDataSource _remote;

  NutritionRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, NutritionInfo>> getNutrition(String foodName) =>
      apiCall(_remote.getNutrition(foodName).then((model) => model.toEntity()));
}
