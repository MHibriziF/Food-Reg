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
                  onPressed: () => context.read<CaptureCubit>().retake(),
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
          child: FilledButton.icon(
            onPressed: () => showInfoSnackBar(
              context,
              'Food identification is coming in the next step.',
            ),
            icon: const Icon(Icons.search),
            label: const Text('Analyze'),
          ),
        ),
      ],
    );
  }
}
