import 'package:weather_app/core/error/app_exception.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

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
    } on FormatException {
      throw const AppException(AppExceptionCode.unableToParseWeatherResponse);
    }
  }

  static CurrentWeather _mapCurrent(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: _double(json['temperature_2m']),
      apparentTemperature: _double(json['apparent_temperature']),
      humidity: _int(json['relative_humidity_2m']),
      windSpeed: _double(json['wind_speed_10m']),
      precipitation: _double(json['precipitation']),
      condition: conditionFromCode(_int(json['weather_code'])),
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
      throw const AppException(AppExceptionCode.inconsistentDailyWeatherArrays);
    }

    return List.generate(times.length, (index) {
      return DailyForecast(
        date: DateTime.parse(_string(times[index])),
        condition: conditionFromCode(_int(codes[index])),
        minimumTemperature: _double(minimums[index]),
        maximumTemperature: _double(maximums[index]),
        precipitationProbability: _int(precipitation[index]),
      );
    }, growable: false);
  }

  /// Converts Open-Meteo's WMO weather codes into application domain values.
  static WeatherCondition conditionFromCode(int code) {
    return switch (code) {
      0 => WeatherCondition.clear,
      1 || 2 => WeatherCondition.mostlyClear,
      3 => WeatherCondition.cloudy,
      45 || 48 => WeatherCondition.fog,
      51 || 53 || 55 || 56 || 57 => WeatherCondition.drizzle,
      61 || 63 || 65 || 66 || 67 => WeatherCondition.rain,
      71 || 73 || 75 || 77 => WeatherCondition.snow,
      80 || 81 || 82 || 85 || 86 => WeatherCondition.shower,
      95 || 96 || 99 => WeatherCondition.thunderstorm,
      _ => WeatherCondition.unknown,
    };
  }

  static Map<String, dynamic> _map(Object? value) {
    if (value is Map<String, dynamic>) return value;
    throw const AppException(AppExceptionCode.expectedObject);
  }

  static List<Object?> _list(Object? value) {
    if (value is List) return value;
    throw const AppException(AppExceptionCode.expectedList);
  }

  static String _string(Object? value) {
    if (value is String && value.isNotEmpty) return value;
    throw const AppException(AppExceptionCode.expectedText);
  }

  static int _int(Object? value) {
    if (value is num) return value.toInt();
    throw const AppException(AppExceptionCode.expectedNumber);
  }

  static double _double(Object? value) {
    if (value is num) return value.toDouble();
    throw const AppException(AppExceptionCode.expectedNumber);
  }
}
