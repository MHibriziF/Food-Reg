part of '_widgets.dart';

class NutritionSection extends StatelessWidget {
  const NutritionSection({
    required this.status,
    required this.nutrition,
    super.key,
  });

  final SectionStatus status;
  final NutritionInfo? nutrition;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Nutrition (estimated)',
      icon: Icons.local_fire_department_rounded,
      child: switch (status) {
        SectionStatus.loading => const _SectionLoading(),
        SectionStatus.failure ||
        SectionStatus.empty => const Text(
          "Nutrition info isn't available right now.",
        ),
        SectionStatus.success => _NutritionGrid(nutrition: nutrition!),
      },
    );
  }
}

class _NutritionGrid extends StatelessWidget {
  const _NutritionGrid({required this.nutrition});

  final NutritionInfo nutrition;

  @override
  Widget build(BuildContext context) {
    final items = <(String, String)>[
      ('Calories', '${nutrition.calories.toStringAsFixed(0)} kcal'),
      ('Carbs', '${nutrition.carbs.toStringAsFixed(1)} g'),
      ('Fat', '${nutrition.fat.toStringAsFixed(1)} g'),
      ('Fiber', '${nutrition.fiber.toStringAsFixed(1)} g'),
      ('Protein', '${nutrition.protein.toStringAsFixed(1)} g'),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final (label, value) in items) _NutritionChip(label, value),
      ],
    );
  }
}

class _NutritionChip extends StatelessWidget {
  const _NutritionChip(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: BaseColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: BaseColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: FontTheme.captionMedium),
          Text(value, style: FontTheme.bodyBold),
        ],
      ),
    );
  }
}
