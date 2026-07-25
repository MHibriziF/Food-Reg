part of '_widgets.dart';

class CaptureEmptyBody extends StatelessWidget {
  const CaptureEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant, size: 96, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'Snap or pick a food photo to identify it',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () => context.read<CaptureCubit>().pickImage(
              CaptureSource.camera,
            ),
            icon: const Icon(Icons.photo_camera),
            label: const Text('Take Photo'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.read<CaptureCubit>().pickImage(
              CaptureSource.gallery,
            ),
            icon: const Icon(Icons.photo_library),
            label: const Text('Choose from Gallery'),
          ),
        ],
      ),
    );
  }
}
