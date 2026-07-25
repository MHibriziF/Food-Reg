part of '_pages.dart';

class FoodDetailArgs {
  const FoodDetailArgs({required this.image, required this.result});

  final File image;
  final ClassificationResult result;
}

class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({required this.args, super.key});

  final FoodDetailArgs args;

  @override
  Widget build(BuildContext context) {
    if (args.result.label == 'Not recognized') {
      return _UnrecognizedView(image: args.image);
    }
    return BlocProvider(
      create: (_) => get<FoodDetailCubit>()..load(args.result.label),
      child: _FoodDetailView(args: args),
    );
  }
}

class _FoodDetailView extends StatelessWidget {
  const _FoodDetailView({required this.args});

  final FoodDetailArgs args;

  @override
  Widget build(BuildContext context) {
    final confidencePercent = (args.result.confidence * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.file(args.image, fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    args.result.label,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.insights_rounded, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '$confidencePercent% confidence',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              BlocBuilder<FoodDetailCubit, FoodDetailState>(
                builder: (context, state) =>
                    MealSection(status: state.mealStatus, meal: state.meal),
              ),
              BlocBuilder<FoodDetailCubit, FoodDetailState>(
                builder: (context, state) => NutritionSection(
                  status: state.nutritionStatus,
                  nutrition: state.nutrition,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnrecognizedView extends StatelessWidget {
  const _UnrecognizedView({required this.image});

  final File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.file(image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "We couldn't confidently identify this as food.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Try a clearer photo focused on the food.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
