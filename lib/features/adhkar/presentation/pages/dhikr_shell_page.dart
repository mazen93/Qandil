import 'package:flutter/material.dart';

import '../../../../core/widgets/qandil_lantern_mark.dart';
import '../../../../l10n/app_localizations.dart';

/// Phase 1 shell page for the Dhikr & Tasbih tab.
class DhikrShellPage extends StatelessWidget {
  const DhikrShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.dhikrShellTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const QandilLanternMark(size: 56),
              const SizedBox(height: 16),
              Text(
                l10n.dhikrShellTitle,
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.dhikrShellDescription,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
