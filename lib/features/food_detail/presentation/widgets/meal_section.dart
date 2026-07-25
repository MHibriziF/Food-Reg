part of '_widgets.dart';

class MealSection extends StatelessWidget {
  const MealSection({required this.status, required this.meal, super.key});

  final SectionStatus status;
  final MealInfo? meal;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Recipe',
      icon: Icons.restaurant_menu_rounded,
      child: switch (status) {
        SectionStatus.loading => const _SectionLoading(),
        SectionStatus.failure => const Text(
          "Couldn't load recipe info right now.",
        ),
        SectionStatus.empty => const Text(
          'No matching recipe found on MealDB.',
        ),
        SectionStatus.success => _MealContent(meal: meal!),
      },
    );
  }
}

class _MealContent extends StatelessWidget {
  const _MealContent({required this.meal});

  final MealInfo meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: meal.thumbnailUrl,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, _) => const SizedBox(height: 160),
            errorWidget: (_, _, _) => const SizedBox.shrink(),
          ),
        ),
        const SizedBox(height: 12),
        Text(meal.name, style: FontTheme.bodyBold),
        const SizedBox(height: 12),
        Text('Ingredients', style: FontTheme.textBold),
        const SizedBox(height: 4),
        ...meal.ingredients.map(
          (i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              '•  ${i.name}${i.measure.isNotEmpty ? ' — ${i.measure}' : ''}',
              style: FontTheme.bodyRegular,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('Instructions', style: FontTheme.textBold),
        const SizedBox(height: 4),
        Text(meal.instructions, style: FontTheme.bodyRegular),
      ],
    );
  }
}
