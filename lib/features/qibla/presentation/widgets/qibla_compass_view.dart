import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/services/qibla_calculator_service.dart';

/// Phase 5 Qibla Compass View:
/// - Bearing from `adhan` (`QiblaCalculatorService`)
/// - Live magnetometer heading stream from `flutter_compass`
/// - Calibration hint (figure-8 motion)
/// - Low-accuracy magnetic interference warning banner
/// - Static bearing fallback card when the device has no compass sensor
class QiblaCompassView extends StatefulWidget {
  const QiblaCompassView({
    required this.qiblaBearingDegrees,
    required this.cityName,
    this.compassStreamOverride,
    super.key,
  });

  final double qiblaBearingDegrees;
  final String cityName;
  final Stream<CompassEvent>? compassStreamOverride;

  @override
  State<QiblaCompassView> createState() => _QiblaCompassViewState();
}

class _QiblaCompassViewState extends State<QiblaCompassView> {
  StreamSubscription<CompassEvent>? _compassSub;
  double? _heading;
  double? _accuracy;
  bool _sensorChecked = false;

  @override
  void initState() {
    super.initState();
    _subscribeToCompass();
  }

  void _subscribeToCompass() {
    try {
      final stream = widget.compassStreamOverride ?? FlutterCompass.events;
      if (stream == null) {
        setState(() => _sensorChecked = true);
        return;
      }
      _compassSub = stream.listen(
        (event) {
          if (!mounted) return;
          setState(() {
            _heading = event.heading;
            _accuracy = event.accuracy;
            _sensorChecked = true;
          });
        },
        onError: (_) {
          if (!mounted) return;
          setState(() => _sensorChecked = true);
        },
      );
      // Mark checked after short timeout if stream emits nothing on emulators
      Future<void>.delayed(const Duration(milliseconds: 600), () {
        if (mounted && !_sensorChecked) {
          setState(() => _sensorChecked = true);
        }
      });
    } catch (_) {
      setState(() => _sensorChecked = true);
    }
  }

  @override
  void dispose() {
    _compassSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;
    final cardinal = QiblaCalculatorService.cardinalDirection(
      widget.qiblaBearingDegrees,
      languageCode: lang,
    );
    final bearingFormatted =
        '${widget.qiblaBearingDegrees.toStringAsFixed(1)}° ($cardinal)';

    final hasLiveHeading = _heading != null;
    final isLowAccuracy =
        _accuracy != null && (_accuracy! < 0 || _accuracy! > 25.0);
    final isAligned = hasLiveHeading &&
        QiblaCalculatorService.isAlignedWithQibla(
          compassHeading: _heading!,
          qiblaBearing: widget.qiblaBearingDegrees,
        );

    return ListView(
      padding: const EdgeInsetsDirectional.all(16),
      children: [
        // Location & Exact Qibla Bearing Card
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.lantern,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        widget.cityName,
                        style: theme.textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.qiblaBearingLabel(bearingFormatted),
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                if (isAligned) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lantern,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      l10n.qiblaAlignedStatus,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.night,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Low-Accuracy Warning Banner
        if (hasLiveHeading && isLowAccuracy) ...[
          Container(
            padding: const EdgeInsetsDirectional.all(12),
            decoration: BoxDecoration(
              color: AppColors.lantern.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lantern),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.lantern,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.qiblaLowAccuracyWarning,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Compass Dial OR Static Bearing Fallback when device has no sensor
        if (hasLiveHeading)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: 260,
                height: 260,
                child: CustomPaint(
                  painter: _QiblaDialPainter(
                    headingDegrees: _heading!,
                    qiblaBearingDegrees: widget.qiblaBearingDegrees,
                    isAligned: isAligned,
                    dialColor: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.explore_off_outlined,
                    size: 48,
                    color: AppColors.lantern,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.qiblaNoSensorFallbackTitle,
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.qiblaNoSensorFallbackBody(bearingFormatted),
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CustomPaint(
                      painter: _QiblaDialPainter(
                        headingDegrees: 0.0,
                        qiblaBearingDegrees: widget.qiblaBearingDegrees,
                        isAligned: false,
                        dialColor: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 16),

        // Calibration Hint Card
        Card(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(14),
            child: Row(
              children: [
                const Icon(
                  Icons.screen_rotation_alt_rounded,
                  color: AppColors.lantern,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.qiblaCalibrationHint,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QiblaDialPainter extends CustomPainter {
  const _QiblaDialPainter({
    required this.headingDegrees,
    required this.qiblaBearingDegrees,
    required this.isAligned,
    required this.dialColor,
  });

  final double headingDegrees;
  final double qiblaBearingDegrees;
  final bool isAligned;
  final Color dialColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 12;

    final ringPaint = Paint()
      ..color =
          isAligned ? AppColors.lantern : dialColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isAligned ? 4.0 : 2.0;

    canvas.drawCircle(center, radius, ringPaint);

    // Rotate dial opposite to device heading so North points to magnetic North
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-headingDegrees * (math.pi / 180.0));

    // Draw North tick mark
    final northPaint = Paint()
      ..color = dialColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(0, -radius),
      Offset(0, -radius + 14),
      northPaint,
    );

    // Rotate to Qibla bearing relative to North and draw Lantern Gold Qibla Needle
    canvas.rotate(qiblaBearingDegrees * (math.pi / 180.0));

    final qiblaNeedlePaint = Paint()
      ..color = AppColors.lantern
      ..style = PaintingStyle.fill;

    final needlePath = Path()
      ..moveTo(0, -radius + 8)
      ..lineTo(12, 16)
      ..lineTo(0, 4)
      ..lineTo(-12, 16)
      ..close();
    canvas.drawPath(needlePath, qiblaNeedlePaint);

    canvas.drawCircle(Offset.zero, 6, Paint()..color = dialColor);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _QiblaDialPainter oldDelegate) {
    return oldDelegate.headingDegrees != headingDegrees ||
        oldDelegate.qiblaBearingDegrees != qiblaBearingDegrees ||
        oldDelegate.isAligned != isAligned ||
        oldDelegate.dialColor != dialColor;
  }
}
