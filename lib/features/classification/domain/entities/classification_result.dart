class ClassificationResult {
  const ClassificationResult({required this.label, required this.confidence});

  final String label;

  /// 0.0–1.0
  final double confidence;
}
