part of '_datasources.dart';

abstract class {{feature_name.pascalCase()}}LocalDataSource {
  Future<void> cache({{feature_name.pascalCase()}}Model model);
  {{feature_name.pascalCase()}}Model? getCached();
  Future<void> clear();
}

@LazySingleton(as: {{feature_name.pascalCase()}}LocalDataSource)
class {{feature_name.pascalCase()}}LocalDataSourceImpl
    implements {{feature_name.pascalCase()}}LocalDataSource {
  static const _key = '{{feature_name.snakeCase()}}_cached';
  static const _ttl = Duration(minutes: 15);

  @override
  Future<void> cache({{feature_name.pascalCase()}}Model model) =>
      HiveService.cacheModel(_key, model, toJson: (m) => m.toJson(), ttl: _ttl);

  @override
  {{feature_name.pascalCase()}}Model? getCached() =>
      HiveService.getCachedModel(_key, fromJson: {{feature_name.pascalCase()}}Model.fromJson);

  @override
  Future<void> clear() => HiveService.remove(_key, box: BoxNames.cache);
}
