import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import 'app_routes.dart';

/// Standard 404 / Route error page.
class AppErrorPage extends StatelessWidget {
  const AppErrorPage({required this.error, super.key});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notFoundTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.notFoundMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
              if (error != null) ...[
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => context.goNamed(AppRoutes.homeName),
                icon: const Icon(Icons.home_rounded),
                label: Text(l10n.backToHome),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
