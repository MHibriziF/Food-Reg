part of '_repositories.dart';

@LazySingleton(as: MealRepository)
class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource _remote;

  MealRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, MealInfo?>> searchByName(String name) =>
      apiCall(_remote.searchByName(name).then((model) => model?.toEntity()));
}
