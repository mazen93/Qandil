import '../../../../core/result/result.dart';
import '../entities/app_settings.dart';

/// Domain contract for loading and persisting user settings.
abstract interface class SettingsRepository {
  Future<Result<AppSettings>> getSettings();

  Future<Result<AppSettings>> saveSettings(AppSettings settings);
}
