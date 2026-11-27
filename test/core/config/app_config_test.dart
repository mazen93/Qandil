import 'package:qandil/core/config/app_config.dart';
import 'package:qandil/core/config/environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig & Environment', () {
    test('Environment parses recognized values correctly', () {
      expect(Environment.fromString('dev'), Environment.development);
      expect(Environment.fromString('development'), Environment.development);
      expect(Environment.fromString('staging'), Environment.staging);
      expect(Environment.fromString('production'), Environment.production);
      expect(Environment.fromString('prod'), Environment.production);
    });

    test(
        'Environment throws ArgumentError for unrecognized environment strings',
        () {
      expect(() => Environment.fromString('unknown_env'), throwsArgumentError);
    });

    test('AppConfig instance holds expected values', () {
      const config = AppConfig(
        appName: 'Test App',
        environment: Environment.development,
        apiBaseUrl: 'https://api.test.com',
        enableLogging: true,
      );

      expect(config.appName, 'Test App');
      expect(config.environment.isDevelopment, isTrue);
      expect(config.apiBaseUrl, 'https://api.test.com');
      expect(config.enableLogging, isTrue);
    });

    test('AppConfig.fromMap parses valid configuration successfully', () {
      final config = AppConfig.fromMap({
        'APP_NAME': 'Parsed App',
        'ENVIRONMENT': 'staging',
        'API_BASE_URL': 'https://api.staging.example.com',
        'ENABLE_LOGGING': true,
      });

      expect(config.appName, 'Parsed App');
      expect(config.environment, Environment.staging);
      expect(config.apiBaseUrl, 'https://api.staging.example.com');
      expect(config.enableLogging, isTrue);
    });

    test('AppConfig.fromMap throws StateError when APP_NAME is missing', () {
      expect(
        () => AppConfig.fromMap({
          'ENVIRONMENT': 'development',
          'API_BASE_URL': 'https://api.dev.example.com',
        }),
        throwsStateError,
      );
    });

    test('AppConfig.fromMap throws StateError when ENVIRONMENT is missing', () {
      expect(
        () => AppConfig.fromMap({
          'APP_NAME': 'App',
          'API_BASE_URL': 'https://api.dev.example.com',
        }),
        throwsStateError,
      );
    });

    test('AppConfig.fromMap throws StateError when API_BASE_URL is missing',
        () {
      expect(
        () => AppConfig.fromMap({
          'APP_NAME': 'App',
          'ENVIRONMENT': 'development',
        }),
        throwsStateError,
      );
    });

    test('AppConfig.fromMap throws ArgumentError when API_BASE_URL is invalid',
        () {
      expect(
        () => AppConfig.fromMap({
          'APP_NAME': 'App',
          'ENVIRONMENT': 'development',
          'API_BASE_URL': 'not-a-valid-url',
        }),
        throwsArgumentError,
      );
    });
  });
}
