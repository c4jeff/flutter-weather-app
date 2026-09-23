import '../../../core/error/app_exception.dart';
import '../../../core/network/json_api_client.dart';
import '../domain/location.dart';

class LocationRepository {
  const LocationRepository(this._client);

  final JsonApiClient _client;

  Future<List<Location>> search(String query) async {
    final normalized = query.trim();
    if (normalized.length < 2) return const [];

    final uri = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
      'name': normalized,
      'count': '8',
      'language': 'zh',
      'format': 'json',
    });
    final json = await _client.get(uri);
    final results = json['results'];
    if (results == null) return const [];
    if (results is! List) {
      throw const AppException(
        AppErrorKind.invalidData,
        'Invalid location results',
      );
    }

    return results.whereType<Map<String, dynamic>>().map(_parse).toList();
  }

  Location _parse(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final latitude = json['latitude'];
    final longitude = json['longitude'];
    final country = json['country'];
    final timezone = json['timezone'];

    if (id is! num ||
        name is! String ||
        latitude is! num ||
        longitude is! num ||
        country is! String ||
        timezone is! String) {
      throw const AppException(
        AppErrorKind.invalidData,
        'Incomplete location data',
      );
    }

    return Location(
      id: id.toInt(),
      name: name,
      latitude: latitude.toDouble(),
      longitude: longitude.toDouble(),
      country: country,
      timezone: timezone,
      adminArea: json['admin1'] is String ? json['admin1'] as String : null,
    );
  }
}
