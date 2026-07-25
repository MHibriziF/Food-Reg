# InagriChat — task runner
# Install: https://github.com/casey/just#packages
# Usage:   just <recipe>

# List all recipes
default:
    @just --list

# ── Setup ────────────────────────────────────────────────────────────────────

# First-time setup after cloning (pub get + mason + codegen)
setup:
    flutter pub get
    mason.bat get
    dart run build_runner build --delete-conflicting-outputs

# Pull latest deps + re-run codegen (use after git pull)
sync:
    flutter pub get
    mason.bat get
    dart run build_runner build --delete-conflicting-outputs

# ── Development ──────────────────────────────────────────────────────────────

# Run the app (debug)
run:
    flutter run

# Run on a specific device
run-device device:
    flutter run -d {{device}}

# Run in release mode
run-release:
    flutter run --release

# ── Code generation ──────────────────────────────────────────────────────────

# Re-run all generators (freezed / injectable / json / envied)
gen:
    dart run build_runner build --delete-conflicting-outputs

# Watch mode — auto-regenerate on file changes during development
watch:
    dart run build_runner watch --delete-conflicting-outputs

# ── Feature scaffolding ──────────────────────────────────────────────────────

# Scaffold a new feature (prompts for name)
feature:
    mason make feature

# ── Quality ──────────────────────────────────────────────────────────────────

# Static analysis
check:
    dart analyze lib/

# Run tests
test:
    flutter test

# Run tests with coverage
test-coverage:
    flutter test --coverage

# ── Maintenance ──────────────────────────────────────────────────────────────

# Clean build artifacts and re-fetch deps
clean:
    flutter clean
    flutter pub get

# Nuclear clean — wipe everything and start fresh
reset:
    flutter clean
    dart pub cache clean
    flutter pub get
    mason.bat get
    dart run build_runner build --delete-conflicting-outputs
