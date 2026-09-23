import '../../../core/network/json_api_client.dart';
import '../../location/domain/location.dart';
import '../domain/weather.dart';
import 'weather_mapper.dart';

class WeatherRepository {
  const WeatherRepository(this._client);

  final JsonApiClient _client;

  Future<WeatherForecast> getForecast(Location location) async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': location.latitude.toString(),
      'longitude': location.longitude.toString(),
      'timezone': location.timezone,
      'forecast_days': '7',
      'current': [
        'temperature_2m',
        'relative_humidity_2m',
        'apparent_temperature',
        'is_day',
        'precipitation',
        'weather_code',
        'wind_speed_10m',
      ].join(','),
      'daily': [
        'weather_code',
        'temperature_2m_max',
        'temperature_2m_min',
        'precipitation_probability_max',
        'precipitation_sum',
      ].join(','),
    });

    return WeatherMapper.fromJson(await _client.get(uri));
  }
}
