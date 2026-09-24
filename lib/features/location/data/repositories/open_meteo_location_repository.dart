import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/core/error/app_exception.dart';
import 'package:weather_app/core/network/api_endpoints.dart';
import 'package:weather_app/core/network/json_api_client.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';

class OpenMeteoLocationRepository implements LocationRepository {
  const OpenMeteoLocationRepository(this._client);

  final JsonApiClient _client;

  @override
  Future<List<Location>> search(
    String query, {
    required String language,
    RequestCancellation? cancellation,
  }) async {
    final normalized = query.trim();
    if (normalized.length < 2) return const [];

    final uri = ApiEndpoints.locationSearch.replace(
      queryParameters: {
        'name': normalized,
        'count': '8',
        'language': language,
        'format': 'json',
      },
    );
    final json = await _client.get(uri, cancellation: cancellation);
    final results = json['results'];
    if (results == null) return const [];
    if (results is! List) {
      throw const AppException(AppExceptionCode.invalidLocationResults);
    }

    return results
        .map((result) {
          if (result is! Map<String, dynamic>) {
            throw const AppException(AppExceptionCode.incompleteLocationData);
          }
          return _parse(result);
        })
        .toList(growable: false);
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
      throw const AppException(AppExceptionCode.incompleteLocationData);
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
