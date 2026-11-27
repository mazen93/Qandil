import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../result/result.dart';
import 'quran_auth_token_provider.dart';

/// Authenticated HTTP client for the Quran Foundation Content API v4.
///
/// Features:
/// - Injects required `x-auth-token` and `x-client-id` headers on every request.
/// - Automatically refreshes token and retries once on HTTP 401 (expired token).
/// - Exponential backoff retry on HTTP 429 (rate limit) and transient 5xx responses.
/// - Maps offline, expired token, 429, 404, and parsing failures into typed [AppFailure].
class QuranApiClient {
  QuranApiClient({
    required http.Client httpClient,
    required QuranAuthTokenProvider tokenProvider,
    required String baseUrl,
    this.maxRetries = 2,
    Future<void> Function(Duration)? delayFn,
  })  : _httpClient = httpClient,
        _tokenProvider = tokenProvider,
        _baseUrl = baseUrl.replaceAll(RegExp(r'/+$'), ''),
        _delayFn = delayFn ?? Future<void>.delayed;

  final http.Client _httpClient;
  final QuranAuthTokenProvider _tokenProvider;
  final String _baseUrl;
  final int maxRetries;
  final Future<void> Function(Duration) _delayFn;

  bool get _isPublicQuranComEndpoint =>
      _baseUrl.contains('api.quran.com/api/v4');

  /// Performs an authenticated GET request against [path] (e.g., `/chapters`) with [queryParameters].
  Future<Result<Map<String, dynamic>>> getJson(
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final baseUri = Uri.parse('$_baseUrl$normalizedPath');
    final uri = (queryParameters == null || queryParameters.isEmpty)
        ? baseUri
        : baseUri.replace(queryParameters: queryParameters);

    var attempt = 0;
    var hasRetriedAuth = false;

    while (true) {
      QuranAuthCredentials? credentials;
      if (!_isPublicQuranComEndpoint) {
        final tokenResult = await _tokenProvider.getValidCredentials(
          forceRefresh: hasRetriedAuth,
        );

        switch (tokenResult) {
          case Success(:final value):
            credentials = value;
          case FailureResult(:final failure):
            return FailureResult(failure);
        }
      }

      try {
        final response = await _httpClient.get(
          uri,
          headers: {
            'Accept': 'application/json',
            if (credentials != null) ...{
              'x-auth-token': credentials.accessToken,
              'x-client-id': credentials.clientId,
            },
          },
        );

        // 1. Handle Expired Token (401) -> Refresh token once and retry
        if (response.statusCode == 401) {
          if (!hasRetriedAuth) {
            hasRetriedAuth = true;
            _tokenProvider.invalidate();
            continue;
          }
          return const FailureResult(
            TokenExpiredFailure(
              'Session token expired and could not be refreshed. Please try again.',
            ),
          );
        }

        // 2. Handle Forbidden (403)
        if (response.statusCode == 403) {
          return const FailureResult(
            UnauthorizedFailure(
              'Access denied by Quran Foundation API. Check client permissions.',
            ),
          );
        }

        // 3. Handle Rate Limiting (429) with backoff retry
        if (response.statusCode == 429) {
          final retryHeader =
              int.tryParse(response.headers['retry-after'] ?? '');
          if (attempt < maxRetries) {
            attempt++;
            final waitDuration = retryHeader != null
                ? Duration(seconds: retryHeader)
                : Duration(milliseconds: 300 * (1 << attempt));
            await _delayFn(waitDuration);
            continue;
          }
          return FailureResult(
            RateLimitFailure(
              'Too many requests (HTTP 429). Please wait a moment and try again.',
              retryAfterSeconds: retryHeader,
            ),
          );
        }

        // 4. Handle Not Found (404) — e.g. Surahs 3..114 on pre-production environment
        if (response.statusCode == 404) {
          return const FailureResult(
            NotFoundFailure(
              'Requested Quran content was not found (note: pre-production only includes Surahs 1 and 2).',
            ),
          );
        }

        // 5. Handle Transient Server Failures (5xx) with backoff retry
        if (response.statusCode >= 500) {
          if (attempt < maxRetries) {
            attempt++;
            await _delayFn(Duration(milliseconds: 300 * (1 << attempt)));
            continue;
          }
          return FailureResult(
            ServerFailure(
              'Quran Foundation server error (HTTP ${response.statusCode}). Please try again later.',
            ),
          );
        }

        // 6. Other non-2xx statuses
        if (response.statusCode < 200 || response.statusCode >= 300) {
          return FailureResult(
            ServerFailure(
              'Request failed with HTTP ${response.statusCode}.',
            ),
          );
        }

        // 7. Parse UTF-8 JSON body strictly preserving all Arabic diacritics and glyphs
        final bodyText = utf8.decode(response.bodyBytes);
        final decoded = jsonDecode(bodyText);
        if (decoded is! Map<String, dynamic>) {
          return const FailureResult(
            ParsingFailure('Expected JSON object from Quran Content API.'),
          );
        }
        return Success(decoded);
      } on SocketException {
        return const FailureResult(
          NetworkFailure(
            'You are offline. Connect to the internet or use downloaded content.',
          ),
        );
      } on http.ClientException {
        return const FailureResult(
          NetworkFailure(
            'Network connection interrupted while loading Quran data.',
          ),
        );
      } on FormatException catch (e) {
        return FailureResult(
          ParsingFailure('Failed to parse Quran API response: ${e.message}'),
        );
      } catch (e) {
        return FailureResult(
          UnexpectedFailure('Unexpected error loading Quran data: $e'),
        );
      }
    }
  }
}
