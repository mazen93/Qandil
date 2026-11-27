import 'package:adhan/adhan.dart';

/// Pure Dart Qibla direction calculator powered by `adhan`.
abstract final class QiblaCalculatorService {
  /// Computes the great-circle Qibla bearing in degrees clockwise from True North (`0.0`..`360.0`).
  static double calculateQiblaBearing({
    required double latitude,
    required double longitude,
  }) {
    final qibla = Qibla(Coordinates(latitude, longitude));
    final raw = qibla.direction % 360.0;
    return raw < 0 ? raw + 360.0 : raw;
  }

  /// Computes the shortest signed angular difference (`-180.0`..`+180.0`) from
  /// the device's current [compassHeading] to [qiblaBearing].
  static double angularDelta({
    required double compassHeading,
    required double qiblaBearing,
  }) {
    final diff = (qiblaBearing - compassHeading + 540.0) % 360.0 - 180.0;
    return diff;
  }

  /// Returns `true` when the user's phone heading is aligned with Qibla within [toleranceDegrees].
  static bool isAlignedWithQibla({
    required double compassHeading,
    required double qiblaBearing,
    double toleranceDegrees = 5.0,
  }) {
    return angularDelta(
          compassHeading: compassHeading,
          qiblaBearing: qiblaBearing,
        ).abs() <=
        toleranceDegrees;
  }

  /// Returns the localized cardinal/intercardinal direction for a [bearingDegrees] (N, NE, E, SE, S, SW, W, NW).
  static String cardinalDirection(
    double bearingDegrees, {
    required String languageCode,
  }) {
    final normalized = ((bearingDegrees % 360) + 360) % 360;
    final index = ((normalized + 22.5) ~/ 45) % 8;

    const enDirections = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    const arDirections = [
      'شمال',
      'شمال شرق',
      'شرق',
      'جنوب شرق',
      'جنوب',
      'جنوب غرب',
      'غرب',
      'شمال غرب',
    ];

    return languageCode == 'ar' ? arDirections[index] : enDirections[index];
  }
}
