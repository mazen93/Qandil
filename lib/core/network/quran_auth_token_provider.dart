import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../result/result.dart';

/// Short-lived OAuth2 token bundle returned by the serverless token proxy.
///
/// Contains [accessToken] (`x-auth-token`) and [clientId] (`x-client-id`),
/// never any client secret.
class QuranAuthCredentials {
  const QuranAuthCredentials({
    required this.accessToken,
    required this.clientId,
    required this.expiresAt,
  });

  final String accessToken;
  final String clientId;
  final DateTime expiresAt;

  bool isExpired({
    DateTime? now,
    Duration safetyBuffer = const Duration(seconds: 60),
  }) {
    final current = now ?? DateTime.now().toUtc();
    return !current.isBefore(expiresAt.subtract(safetyBuffer));
  }
}

/// Contract for acquiring short-lived Quran Foundation OAuth2 credentials from the serverless proxy.
abstract interface class QuranAuthTokenProvider {
  Future<Result<QuranAuthCredentials>> getValidCredentials({
    bool forceRefresh = false,
  });

  void invalidate();
}

/// Default implementation fetching tokens from the serverless proxy and caching them in memory until expiry.
class ProxyQuranAuthTokenProvider implements QuranAuthTokenProvider {
  ProxyQuranAuthTokenProvider({
    required http.Client httpClient,
    required String tokenProxyUrl,
    DateTime Function()? clock,
  })  : _httpClient = httpClient,
        _tokenProxyUrl = tokenProxyUrl,
        _clock = clock ?? (() => DateTime.now().toUtc());

  final http.Client _httpClient;
  final String _tokenProxyUrl;
  final DateTime Function() _clock;

  QuranAuthCredentials? _cachedCredentials;

  @override
  void invalidate() {
    _cachedCredentials = null;
  }

  @override
  Future<Result<QuranAuthCredentials>> getValidCredentials({
    bool forceRefresh = false,
  }) async {
    final now = _clock();
    if (!forceRefresh &&
        _cachedCredentials != null &&
        !_cachedCredentials!.isExpired(now: now)) {
      return Success(_cachedCredentials!);
    }

    try {
      final response = await _httpClient.post(
        Uri.parse(_tokenProxyUrl),
        headers: const {'Accept': 'application/json'},
      );

      if (response.statusCode == 429) {
        final retryAfter = int.tryParse(response.headers['retry-after'] ?? '');
        return FailureResult(
          RateLimitFailure(
            'Rate limit reached on token proxy. Please try again shortly.',
            retryAfterSeconds: retryAfter,
          ),
        );
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        return const FailureResult(
          UnauthorizedFailure('Unauthorized to obtain Quran API access token.'),
        );
      }

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return FailureResult(
          ServerFailure(
            'Token proxy returned HTTP ${response.statusCode}.',
          ),
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        return const FailureResult(
          ParsingFailure('Malformed JSON response from token proxy.'),
        );
      }

      final accessToken = (decoded['accessToken'] as String?)?.trim() ??
          (decoded['access_token'] as String?)?.trim() ??
          '';
      final clientId = (decoded['clientId'] as String?)?.trim() ??
          (decoded['client_id'] as String?)?.trim() ??
          '';

      if (accessToken.isEmpty || clientId.isEmpty) {
        return const FailureResult(
          ParsingFailure(
            'Token proxy response missing accessToken or clientId.',
          ),
        );
      }

      DateTime expiresAt;
      final rawExpiresAt = decoded['expiresAt'] as String?;
      final rawExpiresIn = decoded['expiresIn'] ?? decoded['expires_in'];
      if (rawExpiresAt != null && DateTime.tryParse(rawExpiresAt) != null) {
        expiresAt = DateTime.parse(rawExpiresAt).toUtc();
      } else if (rawExpiresIn is num) {
        expiresAt = now.add(Duration(seconds: rawExpiresIn.toInt()));
      } else {
        expiresAt = now.add(const Duration(hours: 1));
      }

      final credentials = QuranAuthCredentials(
        accessToken: accessToken,
        clientId: clientId,
        expiresAt: expiresAt,
      );
      _cachedCredentials = credentials;
      return Success(credentials);
    } on SocketException {
      return const FailureResult(
        NetworkFailure(
          'No internet connection. Please check your network and try again.',
        ),
      );
    } on http.ClientException {
      return const FailureResult(
        NetworkFailure(
          'Network error while connecting to the token service.',
        ),
      );
    } on FormatException catch (e) {
      return FailureResult(
        ParsingFailure('Invalid token response format: ${e.message}'),
      );
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Unexpected error acquiring token: $e'),
      );
    }
  }
}
