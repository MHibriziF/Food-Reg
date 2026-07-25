# Food Reg

A Flutter app that identifies food from a photo (on-device TFLite model, with the model
also hosted on Firebase ML for dynamic download), then shows a recipe (MealDB) and
estimated nutrition (Gemini API) for the result.

## Prerequisites

- Flutter SDK (see `environment.sdk` in `pubspec.yaml` for the required version)
- An Android emulator/device (this app uses the camera, gallery, and cropper — those
  need a real Android/iOS target, not desktop/web)

## Setup

1. **Install dependencies**
   ```
   flutter pub get
   ```

2. **Environment variables** — copy the example file and fill in your own Gemini key:
   ```
   cp .env.example .env
   ```
   Get a free key at [aistudio.google.com/apikey](https://aistudio.google.com/apikey)
   and set `GEMINI_API_KEY` in `.env`. `MEALDB_BASE_URL` already has a working default.

3. **Firebase config** — `android/app/google-services.json` isn't committed to the repo.
   Either ask a project maintainer for it, or generate your own by running
   `flutterfire configure` against the `food-reg-dicoding` Firebase project (requires
   access to that project).

4. **Generate code** (Freezed/Injectable/JSON/Envied):
   ```
   dart run build_runner build --delete-conflicting-outputs
   ```
   Re-run this any time you edit `.env` too — the generator doesn't pick up `.env`
   changes automatically, so run `dart run build_runner clean` first if a rebuild
   doesn't seem to take effect.

5. **Run the app**
   ```
   flutter run
   ```

If you have [`just`](https://github.com/casey/just) installed, `just setup` does steps
1 and 4 together, and `just run` runs the app.

## ML model

The food classifier (`assets/model/food_classifier.tflite`, ~21MB) and its labels are
already bundled in the repo for local development. The app tries to fetch the model
from Firebase ML first and falls back to this bundled copy if that's unavailable, so
things work either way.
