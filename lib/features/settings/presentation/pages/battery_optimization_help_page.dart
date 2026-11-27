import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

/// Phase 6 Battery-Optimization Help Screen for Android OEM brands (Samsung, Xiaomi,
/// Huawei, OnePlus/Oppo/Realme) that aggressively kill background work.
class BatteryOptimizationHelpPage extends StatelessWidget {
  const BatteryOptimizationHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final brands = <({String title, String body, IconData icon})>[
      (
        title: l10n.batteryHelpSamsungTitle,
        body: l10n.batteryHelpSamsungBody,
        icon: Icons.phone_android_rounded,
      ),
      (
        title: l10n.batteryHelpXiaomiTitle,
        body: l10n.batteryHelpXiaomiBody,
        icon: Icons.battery_saver_rounded,
      ),
      (
        title: l10n.batteryHelpHuaweiTitle,
        body: l10n.batteryHelpHuaweiBody,
        icon: Icons.power_settings_new_rounded,
      ),
      (
        title: l10n.batteryHelpOnePlusOppoTitle,
        body: l10n.batteryHelpOnePlusOppoBody,
        icon: Icons.settings_power_rounded,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.batteryHelpTitle),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.lantern,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.batteryHelpIntro,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...brands.map(
            (b) => Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(b.icon, color: theme.colorScheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              b.title,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        b.body,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
