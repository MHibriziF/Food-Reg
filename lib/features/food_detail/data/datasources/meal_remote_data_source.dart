part of '_datasources.dart';

abstract class MealRemoteDataSource {
  Future<MealModel?> searchByName(String name);
}

@LazySingleton(as: MealRemoteDataSource)
class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  @override
  Future<MealModel?> searchByName(String name) async {
    final resp = await getRequest<Map<String, dynamic>>(
      EndPoints.mealDbSearch,
      headers: const {'Content-Type': 'application/json'},
      queryParameters: {'s': name},
    );

    final meals = resp.data?['meals'] as List<dynamic>?;
    if (meals == null || meals.isEmpty) return null;
    return MealModel.fromJson(meals.first as Map<String, dynamic>);
  }
}
