# Agent Instructions

This file is the authoritative guide for AI agents working in this repo. Read it fully before making changes.

## Common commands (justfile)

```bash
just setup      # first-time clone setup
just sync       # after git pull (pub get + mason + codegen)
just gen        # re-run all code generators
just watch      # codegen in watch mode during development
just feature    # scaffold a new feature with mason
just check      # dart analyze lib/
just test       # flutter test
just clean      # flutter clean + pub get
just reset      # nuclear clean — wipes pub cache and regenerates everything
```

Install `just`: https://github.com/casey/just#packages

---

## Architecture

Clean architecture, strict layer separation:

```
data (datasources → models → repositories)
  ↕  only via abstract interfaces
domain (entities, repository interfaces)
  ↕
presentation (cubit → pages → widgets)
```

- **data** depends on nothing in `presentation` or `domain` implementations
- **domain** depends on nothing except `core/errors` and `core/extensions`
- **presentation** depends on `domain` interfaces only, never on `data` directly

---

## NEVER touch generated files

The following files are **machine-generated**. Do not read, edit, or "fix" them:

| Pattern                                    | Generator                 |
| ------------------------------------------ | ------------------------- |
| `**/*.g.dart`                              | json_serializable, envied |
| `**/*.freezed.dart`                        | freezed                   |
| `lib/services/dependencies/di.config.dart` | injectable_generator      |
| `lib/core/config/config.g.dart`            | envied                    |

**If the analyser reports an error in a generated file:** the analyser is already configured to exclude these files (`analysis_options.yaml`). If you still see one, ignore it — do not edit the generated file. Fix the source file that drives generation instead (e.g. the `@freezed` class or `@injectable` annotation), then instruct the developer to re-run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Code generation workflow

### Scaffolding a new feature

```bash
mason make feature
# enter snake_case name when prompted, e.g. crop_advisory
```

This generates the full `data/domain/presentation` skeleton under `lib/features/<name>/`. Fill in the stubs; do not hand-write the skeleton.

### After changing annotated files

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run this after:

- Adding/removing `@freezed` classes or fields
- Adding/removing `@injectable` / `@Injectable` / `@module` annotations
- Changing `core/config/config.dart` env fields

---

## Storage

Use `HiveService` from `lib/services/storage/_storage.dart`. Never import `shared_preferences` — it was removed.

```dart
// primitives (default box: BoxNames.auth, encrypted)
await HiveService.saveString(StorageKeys.token, value);
HiveService.getString(StorageKeys.token);

// models (default box: BoxNames.cache, plain)
await HiveService.cacheModel('profile', model, toJson: (m) => m.toJson());
HiveService.getCachedModel('profile', fromJson: MyModel.fromJson);

// lists
await HiveService.cacheModelList('crops', list, toJson: (c) => c.toJson());
HiveService.getCachedModelList('crops', fromJson: CropModel.fromJson);
```

Keys live in `lib/core/constants/storage_keys.dart`. Box names are in `lib/services/storage/box_names.dart`.

---

## Use cases

Extend `UseCase<T, A>` from `lib/core/bases/use_case/use_case.dart`. Place use cases under `domain/use_cases/`.

Only create a use case when it earns its place — it must do real work, not just relay a single repository call:

**Worth a use case:**

- Calls two or more repositories and merges the result
- Enforces a business rule (validation, derived state, conditional branching)
- Transforms or maps domain data in a non-trivial way

**Not worth a use case:**

- `execute() => _repo.fetchSomething()` — this is a wrapper; call the repository directly from the cubit

```dart
class GetCropAdvisoryUseCase extends UseCase<Advisory, AdvisoryParams> {
  GetCropAdvisoryUseCase(this._cropRepo, this._weatherRepo);

  @override
  Future<Either<Failure, Advisory>> execute([AdvisoryParams? args]) async {
    final crop = await _cropRepo.getCrop(args!.cropId);
    final weather = await _weatherRepo.getCurrent(args.location);
    return crop.flatMap((c) => weather.map((w) => Advisory.combine(c, w)));
  }
}
```

---

## Dependency injection

- Annotate with `@injectable` (cubit), `@Injectable(as: Interface)` (impl + datasource)
- Re-run build_runner after every annotation change
- Never hand-edit `di.config.dart`
- Third-party singletons (e.g. `Dio`) are registered manually in `di.dart` before `get.init()`

---

## HTTP

Use the helpers from `lib/core/client/_client.dart`:

```dart
final resp = await getRequest<Map<String, dynamic>>(EndPoints.baseUrl + '/path');
final parsed = resp.parse(MyModel.fromJson(resp.dataAsMap));
return Right(parsed);
```

Wrap every call in `apiCall()` inside repository implementations:

```dart
return apiCall(_remote.fetchSomething());
```

---

## Error handling

Return `Either<Failure, T>` from repositories and use-cases. Failure types are in `lib/core/errors/failure.dart`:

- `NetworkFailure` — no connectivity
- `TimeoutFailure` — request timeout
- `NotFoundFailure` — 404
- `GeneralFailure` — catch-all
- `CacheFailure` — local storage error

Use `Left(XFailure(...))` / `Right(value)`. Never throw from a repository.

---

## Logging

Always use `LoggerService`, never raw `Logger()`:

```dart
// correct
LoggerService.i('Loading profile');
LoggerService.e('Failed', error: e);

// wrong — bypasses kDebugMode guard, allocates a new instance each call
Logger().i('Loading profile');
```

---

## Barrel imports

Import the barrel file for each layer, never the individual `part` file:

```dart
// correct
import 'package:food_reg/features/chat/data/models/_models.dart';

// wrong
import 'package:food_reg/features/chat/data/models/chat_model.dart';
```

---

## Either

Use `package:either_dart/either.dart`. Fold takes positional args:

```dart
result.fold(
  (failure) => emit(state.copyWith(status: Status.failure, errorMessage: failure.message)),
  (parsed)  => emit(state.copyWith(status: Status.success, data: parsed.data)),
);
```

Do not switch to `dart_either` — it uses named parameters and is incompatible with the established pattern.

---

## What NOT to do

- Do not edit any `*.g.dart` or `*.freezed.dart` file
- Do not import `shared_preferences` — use `HiveService`
- Do not use raw `Logger()` — use `LoggerService`
- Do not write features by hand — use `mason make feature` for the skeleton
- Do not add `import` statements to `part` files — imports go in the library barrel (`_<name>.dart`)
- Do not register injectable classes manually in `di.dart` — annotate and re-run build_runner
- Do not add `dartz` — the project uses `either_dart`
