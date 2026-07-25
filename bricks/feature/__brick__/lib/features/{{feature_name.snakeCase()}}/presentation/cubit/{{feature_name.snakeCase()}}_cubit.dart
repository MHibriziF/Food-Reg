part of '_cubits.dart';

@injectable
class {{feature_name.pascalCase()}}Cubit extends Cubit<{{feature_name.pascalCase()}}State> {
  final {{feature_name.pascalCase()}}Repository _repository;

  {{feature_name.pascalCase()}}Cubit(this._repository)
      : super({{feature_name.pascalCase()}}State.initial());
}
