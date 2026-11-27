import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';
import '../../core/database/app_database.dart';
import '../../core/network/quran_api_client.dart';
import '../../core/network/quran_auth_token_provider.dart';
import '../../core/notifications/adhan_player_service.dart';
import '../../core/notifications/local_notification_service.dart';
import '../../core/result/result.dart';
import '../../features/adhkar/data/repositories/adhkar_repository_impl.dart';
import '../../features/adhkar/domain/repositories/adhkar_repository.dart';
import '../../features/adhkar/presentation/cubit/adhkar_cubit.dart';
import '../../features/audio/data/repositories/audio_repository_impl.dart';
import '../../features/audio/data/services/audio_offline_download_manager.dart';
import '../../features/audio/data/services/quran_audio_player_service.dart';
import '../../features/audio/domain/repositories/audio_repository.dart';
import '../../features/audio/presentation/cubit/audio_cubit.dart';
import '../../features/hifz/data/repositories/hifz_repository_impl.dart';
import '../../features/hifz/domain/repositories/hifz_repository.dart';
import '../../features/hifz/presentation/cubit/hifz_cubit.dart';
import '../../features/home/domain/services/home_widget_sync_service.dart';
import '../../features/home/presentation/cubit/home_view_model.dart';
import '../../features/prayer/data/services/location_service.dart';
import '../../features/prayer/presentation/cubit/prayer_cubit.dart';
import '../../features/quran/data/repositories/offline_first_quran_repository_impl.dart';
import '../../features/quran/data/repositories/quran_local_repository_impl.dart';
import '../../features/quran/data/repositories/quran_remote_repository_impl.dart';
import '../../features/quran/data/repositories/quran_text_pack_download_manager.dart';
import '../../features/quran/domain/repositories/quran_repository.dart';
import '../../features/quran/domain/services/dnd_platform_gateway.dart';
import '../../features/quran/domain/services/reading_mode_service.dart';
import '../../features/quran/presentation/cubit/quran_reader_cubit.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/entities/app_settings.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/tasbih/data/repositories/tasbih_repository_impl.dart';
import '../../features/tasbih/domain/repositories/tasbih_repository.dart';
import '../../features/tasbih/presentation/cubit/tasbih_cubit.dart';

final GetIt getIt = GetIt.instance;

/// Eagerly loads [AppSettings] from the local DB and registers it as a singleton
/// so [SettingsCubit] can start in the already-loaded state.
/// Call this after [registerDependencies] but BEFORE [runApp].
Future<void> preloadSettingsBeforeRunApp() async {
  final repo = getIt<SettingsRepository>();
  final result = await repo.getSettings();
  final preloaded = switch (result) {
    Success(:final value) => value,
    _ => const AppSettings(),
  };
  if (getIt.isRegistered<AppSettings>()) {
    await getIt.unregister<AppSettings>();
  }
  getIt.registerSingleton<AppSettings>(preloaded);
}

/// Registers all application dependencies in manual GetIt service locator.
///
/// Optional overrides ([config], [database], [httpClient], [audioPlayerGateway], [notificationGateway])
/// can be provided for testing.
Future<void> registerDependencies({
  AppConfig? config,
  AppDatabase? database,
  http.Client? httpClient,
  AudioPlayerGateway? audioPlayerGateway,
  LocalNotificationGateway? notificationGateway,
  DndPlatformGateway? dndPlatformGateway,
  HomeWidgetSyncGateway? homeWidgetSyncGateway,
}) async {
  // Core configuration
  final effectiveConfig = config ?? AppConfig.fromEnvironment();
  if (getIt.isRegistered<AppConfig>()) {
    await getIt.unregister<AppConfig>();
  }
  getIt.registerSingleton<AppConfig>(effectiveConfig);

  // HTTP client
  if (httpClient != null) {
    if (getIt.isRegistered<http.Client>()) {
      await getIt.unregister<http.Client>();
    }
    getIt.registerSingleton<http.Client>(httpClient);
  } else if (!getIt.isRegistered<http.Client>()) {
    getIt.registerLazySingleton<http.Client>(
      http.Client.new,
      dispose: (client) => client.close(),
    );
  }

  // Local Drift SQLite database
  if (database != null) {
    if (getIt.isRegistered<AppDatabase>()) {
      await getIt.unregister<AppDatabase>();
    }
    getIt.registerSingleton<AppDatabase>(
      database,
      dispose: (db) => db.close(),
    );
  } else if (!getIt.isRegistered<AppDatabase>()) {
    getIt.registerLazySingleton<AppDatabase>(
      AppDatabase.new,
      dispose: (db) => db.close(),
    );
  }

  // Phase 6: Local Notification Gateway & Service
  if (notificationGateway != null) {
    if (getIt.isRegistered<LocalNotificationGateway>()) {
      await getIt.unregister<LocalNotificationGateway>();
    }
    getIt.registerSingleton<LocalNotificationGateway>(notificationGateway);
  } else if (!getIt.isRegistered<LocalNotificationGateway>()) {
    getIt.registerLazySingleton<LocalNotificationGateway>(
      FlutterLocalNotificationGateway.new,
    );
  }

  if (!getIt.isRegistered<AdhanPlayerService>()) {
    getIt.registerLazySingleton<AdhanPlayerService>(
      AdhanPlayerService.new,
      dispose: (service) => service.dispose(),
    );
  }

  if (!getIt.isRegistered<LocalNotificationService>()) {
    getIt.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService(
        gateway: getIt<LocalNotificationGateway>(),
        adhanPlayer: getIt<AdhanPlayerService>(),
      ),
    );
  }

  // Quran OAuth2 Token Provider & Authenticated Content API v4 Client
  if (!getIt.isRegistered<QuranAuthTokenProvider>()) {
    getIt.registerLazySingleton<QuranAuthTokenProvider>(
      () => ProxyQuranAuthTokenProvider(
        httpClient: getIt<http.Client>(),
        tokenProxyUrl: getIt<AppConfig>().tokenProxyUrl,
      ),
    );
  }

  if (!getIt.isRegistered<QuranApiClient>()) {
    getIt.registerLazySingleton<QuranApiClient>(
      () => QuranApiClient(
        httpClient: getIt<http.Client>(),
        tokenProvider: getIt<QuranAuthTokenProvider>(),
        baseUrl: getIt<AppConfig>().apiBaseUrl,
      ),
    );
  }

  // Quran Feature: Remote, Local Cache, Offline-First Repository & Download Manager
  if (!getIt.isRegistered<QuranRemoteRepositoryImpl>()) {
    getIt.registerLazySingleton<QuranRemoteRepositoryImpl>(
      () => QuranRemoteRepositoryImpl(apiClient: getIt<QuranApiClient>()),
    );
  }

  if (!getIt.isRegistered<QuranLocalRepositoryImpl>()) {
    getIt.registerLazySingleton<QuranLocalRepositoryImpl>(
      () => QuranLocalRepositoryImpl(database: getIt<AppDatabase>()),
    );
  }

  if (!getIt.isRegistered<QuranRepository>()) {
    getIt.registerLazySingleton<QuranRepository>(
      () => OfflineFirstQuranRepositoryImpl(
        remoteRepository: getIt<QuranRemoteRepositoryImpl>(),
        localRepository: getIt<QuranLocalRepositoryImpl>(),
      ),
    );
  }

  if (!getIt.isRegistered<QuranTextPackDownloadManager>()) {
    getIt.registerLazySingleton<QuranTextPackDownloadManager>(
      () => QuranTextPackDownloadManager(
        database: getIt<AppDatabase>(),
        remoteRepository: getIt<QuranRemoteRepositoryImpl>(),
        localRepository: getIt<QuranLocalRepositoryImpl>(),
      ),
    );
  }

  if (!getIt.isRegistered<QuranReaderCubit>()) {
    getIt.registerFactory<QuranReaderCubit>(
      () => QuranReaderCubit(
        repository: getIt<QuranRepository>(),
        database: getIt<AppDatabase>(),
        localRepository: getIt<QuranLocalRepositoryImpl>(),
      ),
    );
  }

  // Audio Feature: Repository, Offline Download Manager, Player Gateway & Cubit
  if (!getIt.isRegistered<AudioRepository>()) {
    getIt.registerLazySingleton<AudioRepository>(
      () => AudioRepositoryImpl(
        quranRepository: getIt<QuranRepository>(),
        apiClient: getIt<QuranApiClient>(),
        database: getIt<AppDatabase>(),
      ),
    );
  }

  if (!getIt.isRegistered<AudioOfflineDownloadManager>()) {
    getIt.registerLazySingleton<AudioOfflineDownloadManager>(
      () => AudioOfflineDownloadManager(
        database: getIt<AppDatabase>(),
        httpClient: getIt<http.Client>(),
      ),
    );
  }

  if (audioPlayerGateway != null) {
    if (getIt.isRegistered<AudioPlayerGateway>()) {
      await getIt.unregister<AudioPlayerGateway>();
    }
    getIt.registerFactory<AudioPlayerGateway>(() => audioPlayerGateway);
  } else if (!getIt.isRegistered<AudioPlayerGateway>()) {
    getIt.registerFactory<AudioPlayerGateway>(
      QuranAudioPlayerService.new,
    );
  }

  if (!getIt.isRegistered<AudioCubit>()) {
    getIt.registerFactory<AudioCubit>(
      () => AudioCubit(
        repository: getIt<AudioRepository>(),
        playerGateway: getIt<AudioPlayerGateway>(),
        downloadManager: getIt<AudioOfflineDownloadManager>(),
      ),
    );
  }

  // Prayer, Qibla & Location Feature
  if (!getIt.isRegistered<LocationService>()) {
    getIt.registerLazySingleton<LocationService>(
      LocationService.new,
    );
  }

  if (!getIt.isRegistered<PrayerCubit>()) {
    getIt.registerFactory<PrayerCubit>(
      () => PrayerCubit(locationService: getIt<LocationService>()),
    );
  }

  // Phase 7: Tasbih Counter & Statistics Feature
  if (!getIt.isRegistered<TasbihRepository>()) {
    getIt.registerLazySingleton<TasbihRepository>(
      () => TasbihRepositoryImpl(database: getIt<AppDatabase>()),
    );
  }

  if (!getIt.isRegistered<TasbihCubit>()) {
    getIt.registerFactory<TasbihCubit>(
      () => TasbihCubit(repository: getIt<TasbihRepository>()),
    );
  }

  // Phase 8: Adhkar and Duas Feature
  if (!getIt.isRegistered<AdhkarRepository>()) {
    getIt.registerLazySingleton<AdhkarRepository>(
      () => AdhkarRepositoryImpl(database: getIt<AppDatabase>()),
    );
  }

  if (!getIt.isRegistered<AdhkarCubit>()) {
    getIt.registerFactory<AdhkarCubit>(
      () => AdhkarCubit(repository: getIt<AdhkarRepository>()),
    );
  }

  // Phase 9: Reading Mode & Crash-Safe Do Not Disturb Service
  if (dndPlatformGateway != null) {
    if (getIt.isRegistered<DndPlatformGateway>()) {
      await getIt.unregister<DndPlatformGateway>();
    }
    getIt.registerSingleton<DndPlatformGateway>(dndPlatformGateway);
  } else if (!getIt.isRegistered<DndPlatformGateway>()) {
    getIt.registerLazySingleton<DndPlatformGateway>(
      PluginDndPlatformGateway.new,
    );
  }

  if (!getIt.isRegistered<ReadingModeService>()) {
    getIt.registerLazySingleton<ReadingModeService>(
      () => ReadingModeService(
        database: getIt<AppDatabase>(),
        dndGateway: getIt<DndPlatformGateway>(),
      ),
    );
  }

  // Phase 11: Home Screen ViewModel & Home-Screen Widgets Sync Service
  if (homeWidgetSyncGateway != null) {
    if (getIt.isRegistered<HomeWidgetSyncGateway>()) {
      await getIt.unregister<HomeWidgetSyncGateway>();
    }
    getIt.registerSingleton<HomeWidgetSyncGateway>(homeWidgetSyncGateway);
  } else if (!getIt.isRegistered<HomeWidgetSyncGateway>()) {
    getIt.registerLazySingleton<HomeWidgetSyncGateway>(
      PluginHomeWidgetSyncGateway.new,
    );
  }

  if (!getIt.isRegistered<HomeWidgetSyncService>()) {
    getIt.registerLazySingleton<HomeWidgetSyncService>(
      () => HomeWidgetSyncService(gateway: getIt<HomeWidgetSyncGateway>()),
    );
  }

  if (!getIt.isRegistered<HomeViewModel>()) {
    getIt.registerFactory<HomeViewModel>(
      () => HomeViewModel(
        database: getIt<AppDatabase>(),
        localQuranRepository: getIt<QuranLocalRepositoryImpl>(),
        widgetSyncService: getIt<HomeWidgetSyncService>(),
      ),
    );
  }

  // Phase 12: Memorization (Hifz) Tools Feature
  if (!getIt.isRegistered<HifzRepository>()) {
    getIt.registerLazySingleton<HifzRepository>(
      () => HifzRepositoryImpl(database: getIt<AppDatabase>()),
    );
  }

  if (!getIt.isRegistered<HifzCubit>()) {
    getIt.registerFactory<HifzCubit>(
      () => HifzCubit(repository: getIt<HifzRepository>()),
    );
  }

  // Settings Feature: Repository & Cubit
  if (!getIt.isRegistered<SettingsRepository>()) {
    getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(database: getIt<AppDatabase>()),
    );
  }

  if (!getIt.isRegistered<SettingsCubit>()) {
    getIt.registerFactory<SettingsCubit>(
      () => SettingsCubit(
        repository: getIt<SettingsRepository>(),
        notificationService: getIt<LocalNotificationService>(),
        readingModeService: getIt<ReadingModeService>(),
        // initialSettings:
        //     getIt.isRegistered<AppSettings>() ? getIt<AppSettings>() : null,
        initialSettings:
            getIt.isRegistered<AppSettings>() ? getIt<AppSettings>() : null,
      ),
    );
  }
}
