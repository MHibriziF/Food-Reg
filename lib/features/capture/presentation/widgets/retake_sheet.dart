part of '_widgets.dart';

void showRetakeSheet(BuildContext context) {
  final cubit = context.read<CaptureCubit>();
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Take Another Photo'),
            onTap: () {
              Navigator.of(sheetContext).pop();
              cubit.pickImage(CaptureSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.of(sheetContext).pop();
              cubit.pickImage(CaptureSource.gallery);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
