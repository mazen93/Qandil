# Dependency Policy

## Included Production Baseline
* `flutter_bloc: ^9.0.0` — Standardized Cubit/Bloc state management.
* `get_it: ^8.0.3` — Explicit manual service locator for dependency injection.
* `go_router: ^15.1.2` — Declarative routing and deep linking.
* `intl: ^0.20.2` & `flutter_localizations` — Flutter official localization support.

## Included Test Baseline
* `flutter_test` (SDK) — Framework unit and widget testing.
* `bloc_test: ^10.0.0` — Declarative testing for Bloc/Cubit states.
* `mocktail: ^1.0.4` — Type-safe mocking library without code generation.
* `flutter_lints: ^5.0.0` — Base linting rules extended with strict type-safety.

## Policy for Optional Dependencies
Do **not** add dependencies preemptively. Add libraries only when specific feature requirements dictate:
* **Networking:** Add `dio` or `http` when external REST/HTTP calls are required.
* **Storage:** Add `shared_preferences`, `flutter_secure_storage`, or `drift` when persistence is required.
* **Vendors:** Add Firebase, Huawei HMS, analytics, maps, or payments strictly on demand.
