part of '_cubits.dart';

enum {{feature_name.pascalCase()}}Status { initial, loading, success, failure }

@freezed
abstract class {{feature_name.pascalCase()}}State with _${{feature_name.pascalCase()}}State {
  const factory {{feature_name.pascalCase()}}State({
    required {{feature_name.pascalCase()}}Status status,
    String? errorMessage,
  }) = _{{feature_name.pascalCase()}}State;

  factory {{feature_name.pascalCase()}}State.initial() =>
      const {{feature_name.pascalCase()}}State(
        status: {{feature_name.pascalCase()}}Status.initial,
      );
}
