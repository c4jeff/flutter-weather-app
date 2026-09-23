enum WeatherCondition {
  clear,
  mostlyClear,
  cloudy,
  fog,
  drizzle,
  rain,
  snow,
  shower,
  thunderstorm,
  unknown,
}

extension WeatherConditionLabel on WeatherCondition {
  String get label => switch (this) {
    WeatherCondition.clear => '晴朗',
    WeatherCondition.mostlyClear => '少云',
    WeatherCondition.cloudy => '多云',
    WeatherCondition.fog => '有雾',
    WeatherCondition.drizzle => '毛毛雨',
    WeatherCondition.rain => '降雨',
    WeatherCondition.snow => '降雪',
    WeatherCondition.shower => '阵雨',
    WeatherCondition.thunderstorm => '雷暴',
    WeatherCondition.unknown => '未知',
  };
}

WeatherCondition weatherConditionFromCode(int code) {
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

class CurrentWeather {
  const CurrentWeather({
    required this.temperature,
    required this.apparentTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.condition,
    required this.isDay,
    required this.observedAt,
  });

  final double temperature;
  final double apparentTemperature;
  final int humidity;
  final double windSpeed;
  final double precipitation;
  final WeatherCondition condition;
  final bool isDay;
  final DateTime observedAt;
}

class DailyForecast {
  const DailyForecast({
    required this.date,
    required this.condition,
    required this.minimumTemperature,
    required this.maximumTemperature,
    required this.precipitationProbability,
  });

  final DateTime date;
  final WeatherCondition condition;
  final double minimumTemperature;
  final double maximumTemperature;
  final int precipitationProbability;
}

class WeatherForecast {
  const WeatherForecast({
    required this.current,
    required this.daily,
    required this.temperatureUnit,
    required this.windSpeedUnit,
    required this.precipitationUnit,
    required this.timezone,
  });

  final CurrentWeather current;
  final List<DailyForecast> daily;
  final String temperatureUnit;
  final String windSpeedUnit;
  final String precipitationUnit;
  final String timezone;
}
