part of '_repositories.dart';

abstract class ClassificationRepository {
  Future<Either<Failure, ClassificationResult>> classify(File image);
}
