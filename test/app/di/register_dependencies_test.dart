import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/app/di/register_dependencies.dart';
import 'package:qandil/core/config/app_config.dart';
import 'package:qandil/core/config/environment.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/core/network/quran_api_client.dart';
import 'package:qandil/core/network/quran_auth_token_provider.dart';
import 'package:qandil/features/adhkar/domain/repositories/adhkar_repository.dart';
import 'package:qandil/features/adhkar/presentation/cubit/adhkar_cubit.dart';
import 'package:qandil/features/quran/data/repositories/quran_text_pack_download_manager.dart';
import 'package:qandil/features/quran/domain/repositories/quran_repository.dart';
import 'package:qandil/features/settings/domain/repositories/settings_repository.dart';
import 'package:qandil/features/settings/presentation/cubit/settings_cubit.dart';

void main() {
  setUp(() async {
    await getIt.reset();
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('Dependency Injection', () {
    test(
        'registerDependencies registers and resolves all Phase 1 & Phase 2 dependencies',
        () async {
      const testConfig = AppConfig(
        appName: 'Qandil DI Test',
        environment: Environment.development,
        apiBaseUrl: 'https://apis-prelive.quran.foundation/content/api/v4',
        tokenProxyUrl: 'http://127.0.0.1:8787/api/v1/token',
        enableLogging: false,
      );
      final inMemoryDb = AppDatabase(NativeDatabase.memory());

      await registerDependencies(
        config: testConfig,
        database: inMemoryDb,
      );

      expect(getIt.isRegistered<AppConfig>(), isTrue);
      expect(getIt.isRegistered<AppDatabase>(), isTrue);
      expect(getIt.isRegistered<QuranAuthTokenProvider>(), isTrue);
      expect(getIt.isRegistered<QuranApiClient>(), isTrue);
      expect(getIt.isRegistered<QuranRepository>(), isTrue);
      expect(getIt.isRegistered<QuranTextPackDownloadManager>(), isTrue);
      expect(getIt.isRegistered<AdhkarRepository>(), isTrue);
      expect(getIt.isRegistered<AdhkarCubit>(), isTrue);
      expect(getIt.isRegistered<SettingsRepository>(), isTrue);
      expect(getIt.isRegistered<SettingsCubit>(), isTrue);

      final resolvedAdhkarRepo = getIt<AdhkarRepository>();
      expect(resolvedAdhkarRepo, isA<AdhkarRepository>());

      final resolvedAdhkarCubit = getIt<AdhkarCubit>();
      expect(resolvedAdhkarCubit, isA<AdhkarCubit>());
      await resolvedAdhkarCubit.close();

      final resolvedQuranRepo = getIt<QuranRepository>();
      expect(resolvedQuranRepo, isA<QuranRepository>());

      final resolvedDownloadManager = getIt<QuranTextPackDownloadManager>();
      expect(resolvedDownloadManager, isA<QuranTextPackDownloadManager>());

      final resolvedCubit = getIt<SettingsCubit>();
      expect(resolvedCubit, isA<SettingsCubit>());
      await resolvedCubit.close();
    });
  });
}
