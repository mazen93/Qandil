# Architecture Guide

This template follows the approved **Flutter Engineering Standard**, enforcing **Feature-First** organization with clean separation between Presentation, Domain, and Data layers.

```text
lib/
├── app/
│   ├── app.dart                   # MaterialApp.router with themes & l10n
│   ├── di/
│   │   └── register_dependencies.dart # Explicit GetIt composition root
│   ├── router/
│   │   ├── app_error_page.dart    # Declarative 404 / Error screen
│   │   └── app_router.dart        # GoRouter definition
│   └── theme/
│       └── app_theme.dart         # Material 3 light and dark themes
├── core/
│   ├── config/
│   │   ├── app_config.dart        # Validated config from --dart-define-from-file
│   │   └── environment.dart       # Environment enum (dev, staging, prod)
│   ├── result/
│   │   └── result.dart            # Native Dart 3 sealed Result<T> & AppFailure
│   └── widgets/
│       ├── app_error_view.dart    # Operational error presentation with retry
│       └── app_loading_indicator.dart # Consistent loading indicator
├── features/
│   └── items/                     # Generic reference feature
│       ├── data/
│       │   ├── datasources/       # Local/remote data sources
│       │   ├── models/            # DTOs and JSON serialization
│       │   └── repositories/      # Repository implementations
│       ├── domain/
│       │   ├── entities/          # Pure Dart business objects
│       │   └── repositories/      # Abstract repository interfaces
│       └── presentation/
│           ├── cubit/             # Cubit state machines
│           └── pages/             # UI screens & widgets
├── l10n/
│   ├── app_ar.arb                 # Arabic ARB translations (RTL)
│   └── app_en.arb                 # English ARB translations (LTR)
└── main.dart                      # Async bootstrap & app runner
```

---

## Architectural Principles

### 1. Dependency Flow
* **Presentation** depends on **Domain** repository contracts and emits/consumes state via **Bloc/Cubit**.
* **Domain** contains pure Dart models and abstract repository contracts. It has **zero dependencies** on Flutter UI, HTTP clients, or platform APIs.
* **Data** satisfies repository contracts, consumes datasources, and handles serialization and error mapping.

### 2. Error Handling Boundary
* Expected operational failures are represented via the sealed `Result<T>` hierarchy (`Success<T>` or `FailureResult<T>`).
* Data layers catch transport and format exceptions and map them into typed `AppFailure` instances (e.g. `NetworkFailure`, `ParsingFailure`, `UnexpectedFailure`).
* Raw exceptions and unmapped status codes are never leaked into Presentation widgets.

### 3. Dependency Injection
* Manual registration using `getIt` inside `lib/app/di/register_dependencies.dart`.
* No unnecessary service-locator wrappers.
* Every registered dependency is verified via automated integration tests (`test/app/di/register_dependencies_test.dart`).

### 4. Configuration
* Compile-time configuration via `--dart-define-from-file`.
* All required parameters are validated on boot. The application fails fast with descriptive diagnostics if required keys are missing or invalid.

### 5. Localization & RTL
* Built with native Flutter `gen-l10n`.
* Bilingual support (English and Arabic) validated across layout directions.

### 6. State Management Policy: Bloc vs. Cubit
Both **Bloc** and **Cubit** (from `flutter_bloc`) are official, first-class patterns within the standard. Developers should choose deliberately based on workflow complexity:

#### When to use Cubit:
* **Direct, linear state transitions:** Data fetching, state toggles, and straightforward CRUD flows.
* **Direct method invocations:** Situations where event classes would just pass parameters through to a handler without additional transformation.
* **Minimal boilerplate:** Keeps simple features concise, focused, and free of ceremony.

#### When to use Bloc:
* **When event-driven capabilities materially benefit the feature:** Workflows requiring explicit event types, event transformations, concurrency handling (e.g., `debounce`, `throttle`, `droppable`, `restartable`), or event-level observability across multiple asynchronous streams—not merely because ordinary logging or analytics exists.
* **Complex multi-event state coordination:** State machines where multiple distinct event inputs coordinate complex state mutations.

#### Why the Starter Template Demonstrates Cubit:
The template's reference feature (`items`) deliberately implements **`ItemsCubit`** because loading a list of items is a direct asynchronous query. Creating separate event classes (`LoadItemsEvent`, `RefreshItemsEvent`) for this workflow would introduce ceremonial boilerplate without improving architecture or testability.

#### How to Implement Bloc in This Architecture:
When a new feature requires Bloc:
1. Place events, states, and the bloc under `lib/features/<feature>/presentation/bloc/`.
2. Define sealed event hierarchies:
   ```dart
   sealed class SearchEvent { const SearchEvent(); }
   final class SearchQueryChanged extends SearchEvent {
     const SearchQueryChanged(this.query);
     final String query;
   }
   ```
3. Register the Bloc as a factory in `register_dependencies.dart`:
   ```dart
   getIt.registerFactory<SearchBloc>(() => SearchBloc(repository: getIt<SearchRepository>()));
   ```
4. Write comprehensive, behavior-focused tests for meaningful state transitions, success/failure outcomes, and relevant edge cases using `blocTest<SearchBloc, SearchState>` without enforcing arbitrary literal 100% coverage.
