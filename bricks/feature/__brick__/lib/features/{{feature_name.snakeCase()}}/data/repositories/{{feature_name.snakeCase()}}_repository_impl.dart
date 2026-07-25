part of '_repositories.dart';

@LazySingleton(as: {{feature_name.pascalCase()}}Repository)
class {{feature_name.pascalCase()}}RepositoryImpl
    implements {{feature_name.pascalCase()}}Repository {
  final {{feature_name.pascalCase()}}RemoteDataSource _remote;
  final {{feature_name.pascalCase()}}LocalDataSource _local;

  {{feature_name.pascalCase()}}RepositoryImpl(this._remote, this._local);
}
