import '../../../core/error/app_exception.dart';
import '../domain/weather.dart';

abstract final class WeatherMapper {
  static WeatherForecast fromJson(Map<String, dynamic> json) {
    try {
      final current = _mapCurrent(_map(json['current']));
      final currentUnits = _map(json['current_units']);
      final daily = _mapDaily(_map(json['daily']));
      final dailyUnits = _map(json['daily_units']);

      return WeatherForecast(
        current: current,
        daily: daily,
        temperatureUnit: _string(currentUnits['temperature_2m']),
        windSpeedUnit: _string(currentUnits['wind_speed_10m']),
        precipitationUnit: _string(
          currentUnits['precipitation'] ?? dailyUnits['precipitation_sum'],
        ),
        timezone: _string(json['timezone']),
      );
    } on AppException {
      rethrow;
    } on Object {
      throw const AppException(
        AppErrorKind.invalidData,
        'Unable to parse weather response',
      );
    }
  }

  static CurrentWeather _mapCurrent(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: _double(json['temperature_2m']),
      apparentTemperature: _double(json['apparent_temperature']),
      humidity: _int(json['relative_humidity_2m']),
      windSpeed: _double(json['wind_speed_10m']),
      precipitation: _double(json['precipitation']),
      condition: weatherConditionFromCode(_int(json['weather_code'])),
      isDay: _int(json['is_day']) == 1,
      observedAt: DateTime.parse(_string(json['time'])),
    );
  }

  static List<DailyForecast> _mapDaily(Map<String, dynamic> json) {
    final times = _list(json['time']);
    final codes = _list(json['weather_code']);
    final minimums = _list(json['temperature_2m_min']);
    final maximums = _list(json['temperature_2m_max']);
    final precipitation = _list(json['precipitation_probability_max']);
    final lengths = {
      times.length,
      codes.length,
      minimums.length,
      maximums.length,
      precipitation.length,
    };
    if (lengths.length != 1 || times.isEmpty) {
      throw const AppException(
        AppErrorKind.invalidData,
        'Daily weather arrays are inconsistent',
      );
    }

    return List.generate(times.length, (index) {
      return DailyForecast(
        date: DateTime.parse(_string(times[index])),
        condition: weatherConditionFromCode(_int(codes[index])),
        minimumTemperature: _double(minimums[index]),
        maximumTemperature: _double(maximums[index]),
        precipitationProbability: _int(precipitation[index]),
      );
    }, growable: false);
  }

  static Map<String, dynamic> _map(Object? value) {
    if (value is Map<String, dynamic>) return value;
    throw const AppException(AppErrorKind.invalidData, 'Expected an object');
  }

  static List<Object?> _list(Object? value) {
    if (value is List) return value;
    throw const AppException(AppErrorKind.invalidData, 'Expected a list');
  }

  static String _string(Object? value) {
    if (value is String && value.isNotEmpty) return value;
    throw const AppException(AppErrorKind.invalidData, 'Expected text');
  }

  static int _int(Object? value) {
    if (value is num) return value.toInt();
    throw const AppException(AppErrorKind.invalidData, 'Expected a number');
  }

  static double _double(Object? value) {
    if (value is num) return value.toDouble();
    throw const AppException(AppErrorKind.invalidData, 'Expected a number');
  }
}
