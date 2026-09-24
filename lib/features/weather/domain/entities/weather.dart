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
