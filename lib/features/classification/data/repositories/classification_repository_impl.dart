part of '_repositories.dart';

@LazySingleton(as: ClassificationRepository)
class ClassificationRepositoryImpl implements ClassificationRepository {
  final ClassificationLocalDataSource _local;

  ClassificationRepositoryImpl(this._local);

  @override
  Future<Either<Failure, ClassificationResult>> classify(File image) =>
      apiCall(_local.classify(image));
}
