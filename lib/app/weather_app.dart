import 'package:flutter/material.dart';

import 'package:weather_app/app/theme/weather_theme.dart';
import 'package:weather_app/features/home/presentation/weather_home_page.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      debugShowCheckedModeBanner: false,
      theme: WeatherTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const WeatherHomePage(),
    );
  }
}
