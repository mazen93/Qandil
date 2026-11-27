import 'environment.dart';

/// Validated application configuration loaded compile-time via `--dart-define-from-file`.
class AppConfig {
  const AppConfig({
    required this.appName,
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
    this.tokenProxyUrl = 'http://127.0.0.1:8787/api/v1/token',
  });

  /// Factory that reads compile-time environment variables and strictly validates them.
  factory AppConfig.fromEnvironment() {
    return AppConfig.fromMap(const {
      'APP_NAME': String.fromEnvironment('APP_NAME'),
      'ENVIRONMENT': String.fromEnvironment('ENVIRONMENT'),
      'API_BASE_URL': String.fromEnvironment('API_BASE_URL'),
      'TOKEN_PROXY_URL': String.fromEnvironment('TOKEN_PROXY_URL'),
      'ENABLE_LOGGING': bool.fromEnvironment('ENABLE_LOGGING'),
    });
  }

  /// Factory validating raw configuration mapping, ensuring no missing or invalid values.
  /// Throws [StateError] or [ArgumentError] when required keys are absent or invalid.
  factory AppConfig.fromMap(Map<String, dynamic> map) {
    final rawAppName = (map['APP_NAME'] as String?)?.trim() ?? '';
    final rawEnvironment = (map['ENVIRONMENT'] as String?)?.trim() ?? '';
    final rawApiBaseUrl = (map['API_BASE_URL'] as String?)?.trim() ?? '';
    final rawTokenProxyUrl = (map['TOKEN_PROXY_URL'] as String?)?.trim() ?? '';
    final enableLogging = map['ENABLE_LOGGING'] == true;

    if (rawAppName.isEmpty) {
      throw StateError(
        'Missing required configuration: "APP_NAME". '
        'Provide a configuration file via --dart-define-from-file=<path_to_config>.',
      );
    }

    if (rawEnvironment.isEmpty) {
      throw StateError(
        'Missing required configuration: "ENVIRONMENT". '
        'Supported values: development, staging, production.',
      );
    }

    if (rawApiBaseUrl.isEmpty) {
      throw StateError(
        'Missing required configuration: "API_BASE_URL". '
        'Must provide a valid HTTP/HTTPS URL.',
      );
    }

    final uri = Uri.tryParse(rawApiBaseUrl);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      throw ArgumentError.value(
        rawApiBaseUrl,
        'API_BASE_URL',
        'Must be a valid HTTP or HTTPS URL (e.g., https://apis-prelive.quran.foundation/content/api/v4).',
      );
    }

    final effectiveTokenProxyUrl = rawTokenProxyUrl.isEmpty
        ? 'http://127.0.0.1:8787/api/v1/token'
        : rawTokenProxyUrl;

    final proxyUri = Uri.tryParse(effectiveTokenProxyUrl);
    if (proxyUri == null ||
        !proxyUri.hasScheme ||
        (proxyUri.scheme != 'http' && proxyUri.scheme != 'https')) {
      throw ArgumentError.value(
        effectiveTokenProxyUrl,
        'TOKEN_PROXY_URL',
        'Must be a valid HTTP or HTTPS URL.',
      );
    }

    final environment = Environment.fromString(rawEnvironment);

    return AppConfig(
      appName: rawAppName,
      environment: environment,
      apiBaseUrl: rawApiBaseUrl,
      tokenProxyUrl: effectiveTokenProxyUrl,
      enableLogging: enableLogging,
    );
  }

  final String appName;
  final Environment environment;
  final String apiBaseUrl;
  final String tokenProxyUrl;
  final bool enableLogging;

  @override
  String toString() =>
      'AppConfig(appName: $appName, environment: ${environment.name}, apiBaseUrl: $apiBaseUrl, tokenProxyUrl: $tokenProxyUrl, enableLogging: $enableLogging)';
}
