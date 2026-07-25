part of '_pages.dart';

class CapturePage extends StatelessWidget {
  const CapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => get<CaptureCubit>(),
      child: const _CaptureView(),
    );
  }
}

class _CaptureView extends StatelessWidget {
  const _CaptureView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Reg')),
      body: SafeArea(
        child: BlocConsumer<CaptureCubit, CaptureState>(
          listener: (context, state) {
            if (state.status == CaptureStatus.failure) {
              showErrorSnackBar(
                context,
                state.errorMessage ?? 'Something went wrong.',
              );
            }
          },
          builder: (context, state) {
            if (state.status == CaptureStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == CaptureStatus.ready && state.image != null) {
              return CaptureReadyBody(image: state.image!);
            }
            return const CaptureEmptyBody();
          },
        ),
      ),
    );
  }
}
