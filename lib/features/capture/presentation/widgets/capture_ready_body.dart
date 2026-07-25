part of '_widgets.dart';

class CaptureReadyBody extends StatelessWidget {
  const CaptureReadyBody({required this.image, super.key});

  final File image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                color: BaseColors.primary.withValues(alpha: 0.05),
                child: Image.file(image, fit: BoxFit.contain),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => showRetakeSheet(context),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retake'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.read<CaptureCubit>().recrop(),
                  icon: const Icon(Icons.crop),
                  label: const Text('Crop'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: _AnalyzeButton(image: image),
        ),
      ],
    );
  }
}

class _AnalyzeButton extends StatefulWidget {
  const _AnalyzeButton({required this.image});

  final File image;

  @override
  State<_AnalyzeButton> createState() => _AnalyzeButtonState();
}

class _AnalyzeButtonState extends State<_AnalyzeButton> {
  bool _isAnalyzing = false;

  Future<void> _analyze() async {
    setState(() => _isAnalyzing = true);
    final cubit = context.read<CaptureCubit>();
    final result = await cubit.analyze();
    if (!mounted) return;
    setState(() => _isAnalyzing = false);

    result.fold(
      (failure) => showErrorSnackBar(
        context,
        failure.message ?? 'Something went wrong.',
      ),
      (classification) => context.push(
        '/detail',
        extra: FoodDetailArgs(image: widget.image, result: classification),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: _isAnalyzing ? null : _analyze,
      icon: _isAnalyzing
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.search),
      label: Text(_isAnalyzing ? 'Analyzing…' : 'Analyze'),
    );
  }
}
