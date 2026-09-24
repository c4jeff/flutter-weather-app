import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/core/network/json_api_client.dart';
import 'package:weather_app/core/network/api_endpoints.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/value_objects/weather_request.dart';
import 'package:weather_app/features/weather/data/mappers/weather_mapper.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class OpenMeteoWeatherRepository implements WeatherRepository {
  const OpenMeteoWeatherRepository(this._client);

  final JsonApiClient _client;

  @override
  Future<WeatherForecast> getForecast(
    WeatherRequest request, {
    RequestCancellation? cancellation,
  }) async {
    final uri = ApiEndpoints.weatherForecast.replace(
      queryParameters: {
        'latitude': request.latitude.toString(),
        'longitude': request.longitude.toString(),
        'timezone': request.timezone,
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
      },
    );

    return WeatherMapper.fromJson(
      await _client.get(uri, cancellation: cancellation),
    );
  }
}
