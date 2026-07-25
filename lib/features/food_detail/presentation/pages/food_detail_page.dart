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
    final confidencePercent = (args.result.confidence * 100).toStringAsFixed(
      1,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.file(args.image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),
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
        ),
      ),
    );
  }
}
