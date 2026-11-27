import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/quran_reader_cubit.dart';
import '../cubit/quran_reader_state.dart';

/// Bottom sheet displaying the Khatmah Planner:
/// - Target days presets (7, 15, 30, 60) + custom
/// - Progress ring widget
/// - Computed pages per day
/// - Missed-day catch-up recommendation
class KhatmahPlannerSheet extends StatefulWidget {
  const KhatmahPlannerSheet({super.key});

  @override
  State<KhatmahPlannerSheet> createState() => _KhatmahPlannerSheetState();
}

class _KhatmahPlannerSheetState extends State<KhatmahPlannerSheet> {
  static const List<int> _presetDays = [7, 15, 30, 60];
  late int _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = context.read<QuranReaderCubit>().state.khatmahTargetDays;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<QuranReaderCubit, QuranReaderState>(
      builder: (context, state) {
        final summary =
            state.copyWith(khatmahTargetDays: _selectedDays).khatmahSummary;
        final percent = (summary.progressFraction * 100).round();

        return SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.khatmahPlannerTitle,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Progress Ring + Daily Pace Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KhatmahProgressRing(
                      progress: summary.progressFraction,
                      size: 88,
                      label: '$percent%',
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.khatmahPagesPerDayResult(
                              summary.basePagesPerDay,
                            ),
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.readerPageHeader(
                              summary.currentPage,
                              state.currentJuzNumber,
                            ),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Target Days Selector
                Text(
                  l10n.khatmahTargetDaysLabel,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _presetDays.map((days) {
                    final isSelected = _selectedDays == days;
                    return ChoiceChip(
                      label: Text('$days'),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => _selectedDays = days);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Missed-Day Catch-Up or On-Track Banner
                Container(
                  padding: const EdgeInsetsDirectional.all(12),
                  decoration: BoxDecoration(
                    color: summary.isBehindSchedule
                        ? AppColors.lantern.withValues(alpha: 0.18)
                        : theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        summary.isBehindSchedule
                            ? Icons.schedule_rounded
                            : Icons.check_circle_outline_rounded,
                        color: theme.colorScheme.onSurface,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          summary.isBehindSchedule
                              ? l10n.khatmahCatchUpWarning(
                                  summary.behindByPages,
                                  summary.catchUpPagesPerDay,
                                  summary.remainingDays,
                                )
                              : l10n.khatmahOnTrackMessage,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    await context
                        .read<QuranReaderCubit>()
                        .updateKhatmahPlan(targetDays: _selectedDays);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(l10n.khatmahSavePlanAction),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Reusable circular progress ring widget painted with Qandil's Lantern/Nile tokens.
class KhatmahProgressRing extends StatelessWidget {
  const KhatmahProgressRing({
    required this.progress,
    this.size = 72,
    this.label,
    super.key,
  });

  final double progress;
  final double size;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _KhatmahRingPainter(
          progress: progress.clamp(0.0, 1.0),
          trackColor: theme.colorScheme.outline.withValues(alpha: 0.35),
          progressColor: AppColors.lantern,
        ),
        child: Center(
          child: Text(
            label ?? '${(progress * 100).round()}%',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _KhatmahRingPainter extends CustomPainter {
  const _KhatmahRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  final double progress;
  final Color trackColor;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 8.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _KhatmahRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}
