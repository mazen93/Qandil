import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qandil/core/result/result.dart';
import 'package:qandil/features/settings/domain/entities/app_settings.dart';
import 'package:qandil/features/settings/domain/repositories/settings_repository.dart';
import 'package:qandil/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:qandil/features/settings/presentation/cubit/settings_state.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late MockSettingsRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const AppSettings());
  });

  setUp(() {
    mockRepository = MockSettingsRepository();
  });

  group('SettingsCubit', () {
    test('initial state defaults to Arabic locale and ThemeMode.system', () {
      final cubit = SettingsCubit(repository: mockRepository);
      expect(cubit.state.settings.languageCode, 'ar');
      expect(cubit.state.settings.themeMode, ThemeMode.system);
      expect(cubit.state.settings.textScaleFactor, 1.0);
      cubit.close();
    });

    blocTest<SettingsCubit, SettingsState>(
      'loadSettings emits loaded SettingsState on repository success',
      build: () {
        when(() => mockRepository.getSettings()).thenAnswer(
          (_) async => const Success(
            AppSettings(
              languageCode: 'ar',
              themeMode: ThemeMode.dark,
              textScaleFactor: 1.15,
            ),
          ),
        );
        return SettingsCubit(repository: mockRepository);
      },
      act: (cubit) => cubit.loadSettings(),
      expect: () => [
        const SettingsState(
          settings: AppSettings(
            languageCode: 'ar',
            themeMode: ThemeMode.dark,
            textScaleFactor: 1.15,
          ),
          isLoaded: true,
        ),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'updateLanguage switches locale from ar to en and persists',
      build: () {
        when(() => mockRepository.saveSettings(any())).thenAnswer(
          (invocation) async => Success(
            invocation.positionalArguments.first as AppSettings,
          ),
        );
        return SettingsCubit(repository: mockRepository);
      },
      act: (cubit) => cubit.updateLanguage('en'),
      expect: () => [
        const SettingsState(
          settings: AppSettings(languageCode: 'en'),
          isLoaded: false,
        ),
        const SettingsState(
          settings: AppSettings(languageCode: 'en'),
          isLoaded: true,
        ),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'updateThemeMode switches theme and persists',
      build: () {
        when(() => mockRepository.saveSettings(any())).thenAnswer(
          (invocation) async => Success(
            invocation.positionalArguments.first as AppSettings,
          ),
        );
        return SettingsCubit(repository: mockRepository);
      },
      act: (cubit) => cubit.updateThemeMode(ThemeMode.dark),
      expect: () => [
        const SettingsState(
          settings: AppSettings(themeMode: ThemeMode.dark),
          isLoaded: false,
        ),
        const SettingsState(
          settings: AppSettings(themeMode: ThemeMode.dark),
          isLoaded: true,
        ),
      ],
    );
  });
}
