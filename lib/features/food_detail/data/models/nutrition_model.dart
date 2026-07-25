part of '_models.dart';

class NutritionModel {
  const NutritionModel({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.protein,
  });

  final double calories;
  final double carbs;
  final double fat;
  final double fiber;
  final double protein;

  factory NutritionModel.fromJson(Map<String, dynamic> json) => NutritionModel(
    calories: (json['calories'] as num).toDouble(),
    carbs: (json['carbs'] as num).toDouble(),
    fat: (json['fat'] as num).toDouble(),
    fiber: (json['fiber'] as num).toDouble(),
    protein: (json['protein'] as num).toDouble(),
  );

  NutritionInfo toEntity() => NutritionInfo(
    calories: calories,
    carbs: carbs,
    fat: fat,
    fiber: fiber,
    protein: protein,
  );
}
