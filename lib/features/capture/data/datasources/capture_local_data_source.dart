part of '_datasources.dart';

abstract class CaptureLocalDataSource {
  /// Returns null if the user backs out of the picker without choosing.
  Future<File?> pickImage(ImageSource source);

  /// Returns null if the user cancels the crop screen.
  Future<File?> cropImage(File image);
}

@LazySingleton(as: CaptureLocalDataSource)
class CaptureLocalDataSourceImpl implements CaptureLocalDataSource {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 90);
    if (picked == null) return null;
    return File(picked.path);
  }

  @override
  Future<File?> cropImage(File image) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Photo', aspectRatioLockEnabled: false),
      ],
    );
    if (cropped == null) return null;
    return File(cropped.path);
  }
}
