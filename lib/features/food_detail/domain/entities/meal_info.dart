class Ingredient {
  const Ingredient({required this.name, required this.measure});

  final String name;
  final String measure;
}

class MealInfo {
  const MealInfo({
    required this.name,
    required this.thumbnailUrl,
    required this.ingredients,
    required this.instructions,
  });

  final String name;
  final String thumbnailUrl;
  final List<Ingredient> ingredients;
  final String instructions;
}
