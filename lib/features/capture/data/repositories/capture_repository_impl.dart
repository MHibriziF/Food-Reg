part of '_repositories.dart';

const _kPermissionDeniedCodes = {'camera_access_denied', 'photo_access_denied'};

@LazySingleton(as: CaptureRepository)
class CaptureRepositoryImpl implements CaptureRepository {
  final CaptureLocalDataSource _local;

  CaptureRepositoryImpl(this._local);

  @override
  Future<Either<Failure, File?>> pickImage(CaptureSource source) async {
    try {
      final image = await _local.pickImage(
        source == CaptureSource.camera
            ? ImageSource.camera
            : ImageSource.gallery,
      );
      return Right(image);
    } on PlatformException catch (e) {
      if (_kPermissionDeniedCodes.contains(e.code)) {
        return Left(
          PermissionFailure(
            message:
                'Permission denied. Please allow camera/photo access in '
                'your device settings.',
          ),
        );
      }
      return Left(CameraFailure(message: e.message ?? kGenericErrorMessage));
    } catch (e) {
      return Left(failureFromException(e));
    }
  }

  @override
  Future<Either<Failure, File?>> cropImage(File image) async {
    try {
      final cropped = await _local.cropImage(image);
      return Right(cropped);
    } catch (e) {
      return Left(failureFromException(e));
    }
  }
}
