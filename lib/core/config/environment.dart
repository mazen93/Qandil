enum Environment {
  development,
  staging,
  production;

  static Environment fromString(String value) {
    return switch (value.toLowerCase().trim()) {
      'production' || 'prod' => Environment.production,
      'staging' || 'stage' => Environment.staging,
      'development' || 'dev' => Environment.development,
      _ => throw ArgumentError.value(
          value,
          'value',
          'Unsupported environment. Supported values: development, staging, production.',
        ),
    };
  }

  bool get isProduction => this == Environment.production;
  bool get isStaging => this == Environment.staging;
  bool get isDevelopment => this == Environment.development;
}
