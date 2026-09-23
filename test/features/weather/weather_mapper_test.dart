import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/app_exception.dart';
import 'package:weather_app/features/weather/data/weather_mapper.dart';
import 'package:weather_app/features/weather/domain/weather.dart';

void main() {
  group('WeatherMapper', () {
    test('maps a valid API response into domain models', () {
      final forecast = WeatherMapper.fromJson(_response());

      expect(forecast.current.temperature, 23.6);
      expect(forecast.current.condition, WeatherCondition.mostlyClear);
      expect(forecast.current.isDay, isTrue);
      expect(forecast.daily, hasLength(2));
      expect(forecast.daily.first.maximumTemperature, 28.2);
      expect(forecast.daily.last.precipitationProbability, 60);
      expect(forecast.temperatureUnit, '°C');
      expect(forecast.timezone, 'Asia/Shanghai');
    });

    test('rejects inconsistent daily arrays', () {
      final response = _response();
      (response['daily'] as Map<String, dynamic>)['temperature_2m_min'] = [
        18.0,
      ];

      expect(
        () => WeatherMapper.fromJson(response),
        throwsA(
          isA<AppException>().having(
            (error) => error.kind,
            'kind',
            AppErrorKind.invalidData,
          ),
        ),
      );
    });
  });
}

Map<String, dynamic> _response() => {
  'timezone': 'Asia/Shanghai',
  'current': {
    'time': '2026-09-23T14:00',
    'temperature_2m': 23.6,
    'relative_humidity_2m': 65,
    'apparent_temperature': 24.1,
    'is_day': 1,
    'precipitation': 0.0,
    'weather_code': 2,
    'wind_speed_10m': 12.5,
  },
  'current_units': {
    'temperature_2m': '°C',
    'wind_speed_10m': 'km/h',
    'precipitation': 'mm',
  },
  'daily': {
    'time': ['2026-09-23', '2026-09-24'],
    'weather_code': [2, 61],
    'temperature_2m_max': [28.2, 25.4],
    'temperature_2m_min': [18.0, 17.2],
    'precipitation_probability_max': [20, 60],
  },
  'daily_units': {'precipitation_sum': 'mm'},
};
