part of '_models.dart';

class MealModel {
  const MealModel({
    required this.name,
    required this.thumbnailUrl,
    required this.ingredients,
    required this.measures,
    required this.instructions,
  });

  final String name;
  final String thumbnailUrl;
  final List<String> ingredients;
  final List<String> measures;
  final String instructions;

  /// MealDB spreads ingredients/measures across strIngredient1..20 /
  /// strMeasure1..20, with unused slots as empty (or blank) strings.
  factory MealModel.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    final measures = <String>[];
    for (var i = 1; i <= 20; i++) {
      final ingredient = (json['strIngredient$i'] as String?)?.trim();
      if (ingredient == null || ingredient.isEmpty) continue;
      ingredients.add(ingredient);
      measures.add((json['strMeasure$i'] as String?)?.trim() ?? '');
    }

    return MealModel(
      name: json['strMeal'] as String? ?? '',
      thumbnailUrl: json['strMealThumb'] as String? ?? '',
      ingredients: ingredients,
      measures: measures,
      instructions: (json['strInstructions'] as String? ?? '').trim(),
    );
  }

  MealInfo toEntity() => MealInfo(
    name: name,
    thumbnailUrl: thumbnailUrl,
    ingredients: [
      for (var i = 0; i < ingredients.length; i++)
        Ingredient(name: ingredients[i], measure: measures[i]),
    ],
    instructions: instructions,
  );
}
