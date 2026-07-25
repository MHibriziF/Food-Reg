part of '_datasources.dart';

abstract class ClassificationLocalDataSource {
  Future<ClassificationResult> classify(File image);
}

@LazySingleton(as: ClassificationLocalDataSource)
class ClassificationLocalDataSourceImpl implements ClassificationLocalDataSource {
  static const _firebaseModelName = 'food-classifier';
  static const _modelAsset = 'assets/model/food_classifier.tflite';
  static const _labelsAsset = 'assets/model/labels.txt';
  static const _inputSize = 192;

  // Output tensor is quantized UINT8 with zero_point 0, so raw/outputScale
  // recovers the softmax probability directly.
  static const _outputScale = 1 / 256;

  IsolateInterpreter? _isolateInterpreter;
  List<String>? _labels;

  Future<void> _ensureLoaded() async {
    if (_isolateInterpreter != null) return;
    final interpreter = await _loadInterpreter();
    _isolateInterpreter = await IsolateInterpreter.create(
      address: interpreter.address,
    );
    final raw = await rootBundle.loadString(_labelsAsset);
    _labels = raw.split('\n').where((l) => l.isNotEmpty).toList();
  }

  Future<Interpreter> _loadInterpreter() async {
    try {
      final model = await FirebaseModelDownloader.instance.getModel(
        _firebaseModelName,
        FirebaseModelDownloadType.localModelUpdateInBackground,
      );
      LoggerService.i('Loaded classifier from Firebase ML: ${model.file.path}');
      return Interpreter.fromFile(model.file);
    } catch (e) {
      LoggerService.w('Firebase ML model unavailable, using bundled asset: $e');
      return Interpreter.fromAsset(_modelAsset);
    }
  }

  @override
  Future<ClassificationResult> classify(File image) async {
    final sw = Stopwatch()..start();
    await _ensureLoaded();
    LoggerService.i('classify: model ready in ${sw.elapsedMilliseconds}ms');

    sw.reset();
    final decoded = await img.decodeImageFile(image.path);
    if (decoded == null) {
      throw const FormatException('Unable to decode image');
    }
    LoggerService.i('classify: decode in ${sw.elapsedMilliseconds}ms');

    sw.reset();
    final resized = img.copyResize(
      decoded,
      width: _inputSize,
      height: _inputSize,
    );

    final input = Uint8List(_inputSize * _inputSize * 3);
    var i = 0;
    for (var y = 0; y < _inputSize; y++) {
      for (var x = 0; x < _inputSize; x++) {
        final pixel = resized.getPixel(x, y);
        input[i++] = pixel.r.toInt();
        input[i++] = pixel.g.toInt();
        input[i++] = pixel.b.toInt();
      }
    }
    LoggerService.i('classify: resize+pack in ${sw.elapsedMilliseconds}ms');

    sw.reset();
    final output = Uint8List(_labels!.length);
    await _isolateInterpreter!.run(input, output);
    LoggerService.i('classify: inference in ${sw.elapsedMilliseconds}ms');

    var bestIndex = 0;
    var bestScore = 0;
    for (var i = 0; i < output.length; i++) {
      if (output[i] > bestScore) {
        bestScore = output[i];
        bestIndex = i;
      }
    }

    return ClassificationResult(
      label: _formatLabel(_labels![bestIndex]),
      confidence: bestScore * _outputScale,
    );
  }

  String _formatLabel(String raw) {
    if (raw == '__background__') return 'Not recognized';
    return raw;
  }
}
