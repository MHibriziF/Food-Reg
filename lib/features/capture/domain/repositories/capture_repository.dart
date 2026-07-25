part of '_repositories.dart';

enum CaptureSource { camera, gallery }

abstract class CaptureRepository {
  /// Right(null) means the user backed out of the picker.
  Future<Either<Failure, File?>> pickImage(CaptureSource source);

  /// Right(null) means the user cancelled the crop screen.
  Future<Either<Failure, File?>> cropImage(File image);
}
