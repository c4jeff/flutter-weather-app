import 'package:flutter/material.dart';

import '../../domain/weather.dart';

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
    WeatherCondition.clear => const Color(0xFFFFB21A),
    WeatherCondition.mostlyClear => const Color(0xFF76A9FA),
    WeatherCondition.cloudy => const Color(0xFF76849F),
    WeatherCondition.fog => const Color(0xFF8A94A9),
    WeatherCondition.drizzle ||
    WeatherCondition.rain ||
    WeatherCondition.shower => const Color(0xFF367DEC),
    WeatherCondition.snow => const Color(0xFF79B8D1),
    WeatherCondition.thunderstorm => const Color(0xFF7656B5),
    WeatherCondition.unknown => const Color(0xFF8A94A9),
  };
}
