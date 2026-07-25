part of '_datasources.dart';

abstract class {{feature_name.pascalCase()}}RemoteDataSource {}

@LazySingleton(as: {{feature_name.pascalCase()}}RemoteDataSource)
class {{feature_name.pascalCase()}}RemoteDataSourceImpl
    implements {{feature_name.pascalCase()}}RemoteDataSource {}
