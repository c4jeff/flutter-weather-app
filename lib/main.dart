import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/app/di/app_dependencies.dart';
import 'package:weather_app/app/weather_app.dart';

void main() {
  runApp(
    ProviderScope(overrides: appProviderOverrides, child: const WeatherApp()),
  );
}
