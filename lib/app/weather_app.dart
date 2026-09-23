import 'package:flutter/material.dart';

import '../features/weather/presentation/weather_page.dart';
import 'weather_theme.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '晴雨间',
      debugShowCheckedModeBanner: false,
      theme: WeatherTheme.light,
      home: const WeatherPage(),
    );
  }
}
