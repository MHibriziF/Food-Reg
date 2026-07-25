part of '_widgets.dart';

class CaptureEmptyBody extends StatelessWidget {
  const CaptureEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: BaseColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.restaurant_rounded,
                size: 64,
                color: BaseColors.primary,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'What are you eating?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Snap or pick a photo and we\'ll identify the food for you.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () =>
                  context.read<CaptureCubit>().pickImage(CaptureSource.camera),
              icon: const Icon(Icons.photo_camera),
              label: const Text('Take Photo'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  context.read<CaptureCubit>().pickImage(CaptureSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Choose from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
