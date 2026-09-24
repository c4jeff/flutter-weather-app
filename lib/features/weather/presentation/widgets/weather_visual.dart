import 'package:flutter/material.dart';

import 'package:weather_app/app/theme/weather_colors.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

IconData iconForWeather(WeatherCondition condition) {
  return switch (condition) {
    WeatherCondition.clear => Icons.wb_sunny_rounded,
    WeatherCondition.mostlyClear => Icons.wb_cloudy_rounded,
    WeatherCondition.cloudy => Icons.cloud_rounded,
    WeatherCondition.fog => Icons.foggy,
    WeatherCondition.drizzle => Icons.grain_rounded,
    WeatherCondition.rain => Icons.water_drop_rounded,
    WeatherCondition.snow => Icons.ac_unit_rounded,
    WeatherCondition.shower => Icons.shower_rounded,
    WeatherCondition.thunderstorm => Icons.thunderstorm_rounded,
    WeatherCondition.unknown => Icons.help_outline_rounded,
  };
}

Color colorForWeather(WeatherCondition condition) {
  return switch (condition) {
    WeatherCondition.clear => WeatherColors.sunny,
    WeatherCondition.mostlyClear => WeatherColors.partlyCloudy,
    WeatherCondition.cloudy => WeatherColors.cloudy,
    WeatherCondition.fog => WeatherColors.fog,
    WeatherCondition.drizzle ||
    WeatherCondition.rain ||
    WeatherCondition.shower => WeatherColors.precipitation,
    WeatherCondition.snow => WeatherColors.snow,
    WeatherCondition.thunderstorm => WeatherColors.thunderstorm,
    WeatherCondition.unknown => WeatherColors.textMuted,
  };
}
