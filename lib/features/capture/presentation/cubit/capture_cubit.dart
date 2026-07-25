part of '_cubits.dart';

@injectable
class CaptureCubit extends Cubit<CaptureState> {
  final CaptureRepository _repository;
  final ClassificationRepository _classificationRepository;

  CaptureCubit(this._repository, this._classificationRepository)
    : super(CaptureState.initial());

  Future<void> pickImage(CaptureSource source) async {
    emit(state.copyWith(status: CaptureStatus.loading, errorMessage: null));

    final result = await _repository.pickImage(source);

    await result.fold(
      (failure) async => emit(
        state.copyWith(
          status: CaptureStatus.failure,
          errorMessage: failure.message ?? kGenericErrorMessage,
        ),
      ),
      (picked) async {
        if (picked == null) {
          emit(
            state.copyWith(
              status: state.image != null
                  ? CaptureStatus.ready
                  : CaptureStatus.initial,
            ),
          );
          return;
        }
        await _cropAndEmit(picked);
      },
    );
  }

  Future<void> recrop() async {
    final image = state.image;
    if (image == null) return;
    emit(state.copyWith(status: CaptureStatus.loading, errorMessage: null));
    await _cropAndEmit(image);
  }

  Future<void> _cropAndEmit(File image) async {
    final cropResult = await _repository.cropImage(image);
    final finalImage = cropResult.fold((_) => image, (cropped) => cropped ?? image);
    emit(state.copyWith(status: CaptureStatus.ready, image: finalImage));
  }

  Future<Either<Failure, ClassificationResult>> analyze() {
    final image = state.image;
    if (image == null) {
      return Future.value(
        Left(ArgumentFailure(message: 'No image to analyze.')),
      );
    }
    return _classificationRepository.classify(image);
  }
}
