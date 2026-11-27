import 'package:flutter/material.dart';

import 'qandil_logo.dart';

/// Calm, respectful empty-state widget following `QANDIL_BRAND.md` Section 5 & Phase 10:
/// - Uses the eight-point Rub el Hizb star ornament (`QandilRubElHizbOrnament`) or `QandilLogo`
/// - Reem Kufi Bold title and IBM Plex Sans Arabic muted subtitle
/// - Zero emoji and zero stock imagery.
class QandilEmptyState extends StatelessWidget {
  const QandilEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const QandilRubElHizbOrnament(size: 36),
            if (icon != null) ...[
              const SizedBox(height: 12),
              Icon(
                icon,
                size: 28,
                color: theme.colorScheme.primary,
              ),
            ],
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
