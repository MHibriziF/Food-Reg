part of '_datasources.dart';

abstract class NutritionRemoteDataSource {
  Future<NutritionModel> getNutrition(String foodName);
}

@LazySingleton(as: NutritionRemoteDataSource)
class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  static final _responseSchema = Schema.object(
    properties: {
      'calories': Schema.number(description: 'Estimated calories in kcal'),
      'carbs': Schema.number(description: 'Carbohydrates in grams'),
      'fat': Schema.number(description: 'Fat in grams'),
      'fiber': Schema.number(description: 'Fiber in grams'),
      'protein': Schema.number(description: 'Protein in grams'),
    },
    requiredProperties: ['calories', 'carbs', 'fat', 'fiber', 'protein'],
  );

  late final GenerativeModel _model = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: Config.geminiApiKey,
    systemInstruction: Content.system(GeminiPrompts.nutritionSystemInstruction),
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
      responseSchema: _responseSchema,
    ),
  );

  @override
  Future<NutritionModel> getNutrition(String foodName) async {
    final response = await _model.generateContent([
      Content.text(GeminiPrompts.nutritionPrompt(foodName)),
    ]);

    final text = response.text;
    if (text == null) {
      throw const FormatException('Empty response from Gemini');
    }

    return NutritionModel.fromJson(jsonDecode(text) as Map<String, dynamic>);
  }
}
