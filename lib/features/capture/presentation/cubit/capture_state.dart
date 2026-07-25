part of '_cubits.dart';

enum CaptureStatus { initial, loading, ready, failure }

@freezed
abstract class CaptureState with _$CaptureState {
  const factory CaptureState({
    required CaptureStatus status,
    File? image,
    String? errorMessage,
  }) = _CaptureState;

  factory CaptureState.initial() =>
      const CaptureState(status: CaptureStatus.initial);
}
