import '../../domain/entities/app_settings.dart';

/// Immutable state for [SettingsCubit].
class SettingsState {
  const SettingsState({
    this.settings = const AppSettings(),
    this.isLoaded = false,
    this.errorMessage,
  });

  final AppSettings settings;
  final bool isLoaded;
  final String? errorMessage;

  SettingsState copyWith({
    AppSettings? settings,
    bool? isLoaded,
    String? errorMessage,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoaded: isLoaded ?? this.isLoaded,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsState &&
          runtimeType == other.runtimeType &&
          settings == other.settings &&
          isLoaded == other.isLoaded &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(settings, isLoaded, errorMessage);
}
