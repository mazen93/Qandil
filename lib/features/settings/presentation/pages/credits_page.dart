import 'package:flutter/material.dart';

import '../../../../core/widgets/qandil_lantern_mark.dart';
import '../../../../l10n/app_localizations.dart';

/// Dedicated About, Credits & Privacy Policy screen required by Qandil Master Rules
/// to credit every translation, tafsir, reciter, adhkar dataset, font, data source,
/// and open-source license, alongside Qandil's on-device privacy commitment.
class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.creditsTitle),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(16),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 8),
                const QandilLanternMark(size: 64),
                const SizedBox(height: 12),
                Text(
                  l10n.appTitle,
                  style: theme.textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.appTagline,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'v1.0.0',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          _CreditCard(
            icon: Icons.shield_outlined,
            title: l10n.creditsContentIntegrityTitle,
            body: l10n.creditsContentIntegrityBody,
          ),
          const SizedBox(height: 12),
          _CreditCard(
            icon: Icons.menu_book_outlined,
            title: l10n.creditsQuranSourceTitle,
            body: l10n.creditsQuranSourceBody,
          ),
          const SizedBox(height: 12),
          _CreditCard(
            icon: Icons.record_voice_over_outlined,
            title: l10n.creditsRecitersTitle,
            body: l10n.creditsRecitersBody,
          ),
          const SizedBox(height: 12),
          _CreditCard(
            icon: Icons.translate_rounded,
            title: l10n.creditsTafsirTranslationsTitle,
            body: l10n.creditsTafsirTranslationsBody,
          ),
          const SizedBox(height: 12),
          _CreditCard(
            icon: Icons.auto_stories_outlined,
            title: l10n.creditsAdhkarSourceTitle,
            body: l10n.creditsAdhkarSourceBody,
          ),
          const SizedBox(height: 12),
          _CreditCard(
            icon: Icons.font_download_outlined,
            title: l10n.creditsFontsTitle,
            body: l10n.creditsFontsBody,
          ),
          const SizedBox(height: 12),
          _CreditCard(
            icon: Icons.explore_outlined,
            title: l10n.creditsPrayerHijriTitle,
            body: l10n.creditsPrayerHijriBody,
          ),
          const SizedBox(height: 12),
          _CreditCard(
            icon: Icons.privacy_tip_outlined,
            title: l10n.creditsPrivacyTitle,
            body: l10n.creditsPrivacyBody,
          ),
          const SizedBox(height: 24),
          Semantics(
            button: true,
            label: l10n.creditsOpenSourceLicenses,
            child: ElevatedButton.icon(
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: l10n.appTitle,
                  applicationVersion: '1.0.0',
                  applicationIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: QandilLanternMark(size: 48),
                  ),
                );
              },
              icon: const Icon(Icons.description_outlined),
              label: Text(l10n.creditsOpenSourceLicenses),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  const _CreditCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      container: true,
      child: Card(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 2),
                    child: Icon(icon, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
