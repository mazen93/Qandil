import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/prayer_entities.dart';

/// Gateway abstracting `Geolocator` so [LocationService] can be deterministically unit-tested.
abstract interface class LocationGateway {
  Future<bool> isLocationServiceEnabled();

  Future<LocationPermission> checkPermission();

  Future<LocationPermission> requestPermission();

  Future<({double latitude, double longitude})> getCurrentCoordinates();
}

/// Production implementation of [LocationGateway] using `geolocator` (`when-in-use` only).
class GeolocatorLocationGateway implements LocationGateway {
  const GeolocatorLocationGateway();

  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  @override
  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  @override
  Future<({double latitude, double longitude})> getCurrentCoordinates() async {
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 10),
      ),
    );
    return (latitude: pos.latitude, longitude: pos.longitude);
  }
}

/// Phase 5 Location Service:
/// - Requests `when-in-use` foreground location permission (never background location).
/// - Matches acquired coordinates to the nearest city in the offline catalog (or formats coordinates).
/// - Provides instant offline manual city search fallback across 30+ Egyptian, Arab, and global cities.
/// - Detects whether the user has moved a significant distance ($\ge 10\text{ km}$) to trigger prayer recomputation.
class LocationService {
  const LocationService({
    LocationGateway? gateway,
  }) : _gateway = gateway ?? const GeolocatorLocationGateway();

  final LocationGateway _gateway;

  /// Significant movement threshold (10 kilometers) to trigger prayer schedule recomputation.
  static const double significantDistanceMeters = 10000.0;

  /// Offline curated city catalog with Egyptian cities prioritized first.
  static const List<CityLocationPreset> cityCatalog = [
    CityLocationPreset(
      nameAr: 'القاهرة، مصر',
      nameEn: 'Cairo, Egypt',
      latitude: 30.0444,
      longitude: 31.2357,
    ),
    CityLocationPreset(
      nameAr: 'الإسكندرية، مصر',
      nameEn: 'Alexandria, Egypt',
      latitude: 31.2001,
      longitude: 29.9187,
    ),
    CityLocationPreset(
      nameAr: 'الجيزة، مصر',
      nameEn: 'Giza, Egypt',
      latitude: 30.0131,
      longitude: 31.2089,
    ),
    CityLocationPreset(
      nameAr: 'المنصورة، مصر',
      nameEn: 'Mansoura, Egypt',
      latitude: 31.0409,
      longitude: 31.3785,
    ),
    CityLocationPreset(
      nameAr: 'طنطا، مصر',
      nameEn: 'Tanta, Egypt',
      latitude: 30.7865,
      longitude: 31.0004,
    ),
    CityLocationPreset(
      nameAr: 'أسيوط، مصر',
      nameEn: 'Asyut, Egypt',
      latitude: 27.1809,
      longitude: 31.1837,
    ),
    CityLocationPreset(
      nameAr: 'الأقصر، مصر',
      nameEn: 'Luxor, Egypt',
      latitude: 25.6872,
      longitude: 32.6396,
    ),
    CityLocationPreset(
      nameAr: 'أسوان، مصر',
      nameEn: 'Aswan, Egypt',
      latitude: 24.0889,
      longitude: 32.8998,
    ),
    CityLocationPreset(
      nameAr: 'بورسعيد، مصر',
      nameEn: 'Port Said, Egypt',
      latitude: 31.2653,
      longitude: 32.3019,
    ),
    CityLocationPreset(
      nameAr: 'السويس، مصر',
      nameEn: 'Suez, Egypt',
      latitude: 29.9668,
      longitude: 32.5498,
    ),
    CityLocationPreset(
      nameAr: 'مكة المكرمة، السعودية',
      nameEn: 'Makkah, Saudi Arabia',
      latitude: 21.4225,
      longitude: 39.8262,
    ),
    CityLocationPreset(
      nameAr: 'المدينة المنورة، السعودية',
      nameEn: 'Madinah, Saudi Arabia',
      latitude: 24.4672,
      longitude: 39.6112,
    ),
    CityLocationPreset(
      nameAr: 'الرياض، السعودية',
      nameEn: 'Riyadh, Saudi Arabia',
      latitude: 24.7136,
      longitude: 46.6753,
    ),
    CityLocationPreset(
      nameAr: 'جدة، السعودية',
      nameEn: 'Jeddah, Saudi Arabia',
      latitude: 21.5433,
      longitude: 39.1728,
    ),
    CityLocationPreset(
      nameAr: 'القدس، فلسطين',
      nameEn: 'Jerusalem, Palestine',
      latitude: 31.7683,
      longitude: 35.2137,
    ),
    CityLocationPreset(
      nameAr: 'عمّان، الأردن',
      nameEn: 'Amman, Jordan',
      latitude: 31.9454,
      longitude: 35.9284,
    ),
    CityLocationPreset(
      nameAr: 'دمشق، سوريا',
      nameEn: 'Damascus, Syria',
      latitude: 33.5138,
      longitude: 36.2765,
    ),
    CityLocationPreset(
      nameAr: 'بيروت، لبنان',
      nameEn: 'Beirut, Lebanon',
      latitude: 33.8938,
      longitude: 35.5018,
    ),
    CityLocationPreset(
      nameAr: 'بغداد، العراق',
      nameEn: 'Baghdad, Iraq',
      latitude: 33.3152,
      longitude: 44.3661,
    ),
    CityLocationPreset(
      nameAr: 'الخرطوم، السودان',
      nameEn: 'Khartoum, Sudan',
      latitude: 15.5007,
      longitude: 32.5599,
    ),
    CityLocationPreset(
      nameAr: 'طرابلس، ليبيا',
      nameEn: 'Tripoli, Libya',
      latitude: 32.8872,
      longitude: 13.1913,
    ),
    CityLocationPreset(
      nameAr: 'تونس، تونس',
      nameEn: 'Tunis, Tunisia',
      latitude: 36.8065,
      longitude: 10.1815,
    ),
    CityLocationPreset(
      nameAr: 'الجزائر، الجزائر',
      nameEn: 'Algiers, Algeria',
      latitude: 36.7538,
      longitude: 3.0588,
    ),
    CityLocationPreset(
      nameAr: 'الدار البيضاء، المغرب',
      nameEn: 'Casablanca, Morocco',
      latitude: 33.5731,
      longitude: -7.5898,
    ),
    CityLocationPreset(
      nameAr: 'الدوحة، قطر',
      nameEn: 'Doha, Qatar',
      latitude: 25.2854,
      longitude: 51.5310,
    ),
    CityLocationPreset(
      nameAr: 'الكويت، الكويت',
      nameEn: 'Kuwait City, Kuwait',
      latitude: 29.3759,
      longitude: 47.9774,
    ),
    CityLocationPreset(
      nameAr: 'دبي، الإمارات',
      nameEn: 'Dubai, UAE',
      latitude: 25.2048,
      longitude: 55.2708,
    ),
    CityLocationPreset(
      nameAr: 'مسقط، عُمان',
      nameEn: 'Muscat, Oman',
      latitude: 23.5880,
      longitude: 58.3829,
    ),
    CityLocationPreset(
      nameAr: 'إسطنبول، تركيا',
      nameEn: 'Istanbul, Turkey',
      latitude: 41.0082,
      longitude: 28.9784,
    ),
    CityLocationPreset(
      nameAr: 'لندن، المملكة المتحدة',
      nameEn: 'London, UK',
      latitude: 51.5074,
      longitude: -0.1278,
    ),
  ];

  /// Searches the offline city catalog by Arabic or English name substring.
  static List<CityLocationPreset> searchCities(String query) {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return cityCatalog;
    return cityCatalog
        .where(
          (city) =>
              city.nameAr.toLowerCase().contains(trimmed) ||
              city.nameEn.toLowerCase().contains(trimmed),
        )
        .toList(growable: false);
  }

  /// Computes great-circle Haversine distance in meters between two coordinates.
  static double distanceBetweenMeters({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    const earthRadiusMeters = 6371000.0;
    final dLat = _degToRad(endLatitude - startLatitude);
    final dLon = _degToRad(endLongitude - startLongitude);
    final lat1 = _degToRad(startLatitude);
    final lat2 = _degToRad(endLatitude);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.sin(dLon / 2) *
            math.sin(dLon / 2) *
            math.cos(lat1) *
            math.cos(lat2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  /// Returns `true` if the user has moved at least [significantDistanceMeters] (10 km).
  static bool hasMovedSignificantDistance({
    required double previousLatitude,
    required double previousLongitude,
    required double newLatitude,
    required double newLongitude,
  }) {
    return distanceBetweenMeters(
          startLatitude: previousLatitude,
          startLongitude: previousLongitude,
          endLatitude: newLatitude,
          endLongitude: newLongitude,
        ) >=
        significantDistanceMeters;
  }

  /// Requests `when-in-use` foreground location and resolves the nearest city label.
  Future<Result<CityLocationPreset>> acquireWhenInUseLocation() async {
    try {
      final enabled = await _gateway.isLocationServiceEnabled();
      if (!enabled) {
        return const FailureResult(
          UnauthorizedFailure(
            'Location services are disabled. You can pick your city manually.',
          ),
        );
      }

      var permission = await _gateway.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _gateway.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return const FailureResult(
          UnauthorizedFailure(
            'Location permission denied. Please choose your city manually.',
          ),
        );
      }

      final coords = await _gateway.getCurrentCoordinates();
      final nearest = findNearestCityOrFormat(
        latitude: coords.latitude,
        longitude: coords.longitude,
      );
      return Success(nearest);
    } catch (e) {
      return FailureResult(
        UnexpectedFailure('Could not acquire GPS location: $e'),
      );
    }
  }

  /// Finds the closest preset city if within 60 km, otherwise formats coordinates cleanly.
  static CityLocationPreset findNearestCityOrFormat({
    required double latitude,
    required double longitude,
  }) {
    CityLocationPreset? closest;
    var minDistance = double.infinity;

    for (final city in cityCatalog) {
      final dist = distanceBetweenMeters(
        startLatitude: latitude,
        startLongitude: longitude,
        endLatitude: city.latitude,
        endLongitude: city.longitude,
      );
      if (dist < minDistance) {
        minDistance = dist;
        closest = city;
      }
    }

    if (closest != null && minDistance <= 60000) {
      return CityLocationPreset(
        nameAr: closest.nameAr,
        nameEn: closest.nameEn,
        latitude: latitude,
        longitude: longitude,
      );
    }

    final coordLabel =
        '${latitude.toStringAsFixed(2)}°, ${longitude.toStringAsFixed(2)}°';
    return CityLocationPreset(
      nameAr: 'موقعي الحالي ($coordLabel)',
      nameEn: 'Current Location ($coordLabel)',
      latitude: latitude,
      longitude: longitude,
    );
  }

  static double _degToRad(double deg) => deg * (math.pi / 180.0);
}
