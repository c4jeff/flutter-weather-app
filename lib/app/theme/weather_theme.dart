import 'package:flutter/material.dart';

import 'package:weather_app/app/theme/weather_colors.dart';

abstract final class WeatherTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: WeatherColors.primary,
      brightness: Brightness.light,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: WeatherColors.appBackground,
      fontFamilyFallback: const ['PingFang SC', 'Noto Sans CJK SC'],
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: WeatherColors.textPrimary,
          fontSize: 44,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.8,
        ),
        headlineMedium: TextStyle(
          color: WeatherColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        titleLarge: TextStyle(
          color: WeatherColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: WeatherColors.textPrimary,
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: TextStyle(color: WeatherColors.textSecondary, height: 1.45),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: WeatherColors.textMuted),
        prefixIconColor: WeatherColors.textSecondary,
        suffixIconColor: WeatherColors.textSecondary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: WeatherColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: WeatherColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
