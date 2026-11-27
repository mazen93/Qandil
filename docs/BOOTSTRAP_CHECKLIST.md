# New App Bootstrap Checklist

Follow this checklist when spinning up a new production application from this starter template:

- [ ] **Clone/Copy:** Copy the starter template into your new repository.
- [ ] **Rename Package:**
  - Update `name:` in `pubspec.yaml`.
  - Update imports in `lib/` and `test/` (e.g. `flutter_starter` → `my_new_app`).
  - Update Android namespace and applicationId in `android/app/build.gradle.kts`.
  - Update iOS bundle identifier in `ios/Runner.xcodeproj/project.pbxproj`.
- [ ] **Environment Configuration:**
  - Copy `config/env.json.example` to `config/env.dev.json` and configure appropriate API endpoints.
  - Set up staging and production configurations without committing secrets.
- [ ] **State Management:**
  - Create new features under `lib/features/<feature_name>/` following the `data/`, `domain/`, and `presentation/` layout.
  - Implement Cubits or Blocs for stateful business flows.
- [ ] **Dependency Injection:**
  - Register new repositories and Cubits in `lib/app/di/register_dependencies.dart`.
  - Ensure `test/app/di/register_dependencies_test.dart` passes.
- [ ] **Routing:**
  - Define new routes and parameters in `lib/app/router/app_router.dart`.
- [ ] **Localization:**
  - Add feature translation strings to `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb`.
  - Run `flutter gen-l10n`.
- [ ] **Verification Gates:**
  - Run `dart format --output=none --set-exit-if-changed .`
  - Run `flutter analyze`
  - Run `flutter test --dart-define-from-file=config/env.dev.json`
- [ ] **Platform Signing & Flavors:**
  - Configure Android keystores and iOS signing certificates.
