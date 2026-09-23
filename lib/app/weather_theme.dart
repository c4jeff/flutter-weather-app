import 'package:flutter/material.dart';

abstract final class WeatherTheme {
  static const ink = Color(0xFF16213A);
  static const blue = Color(0xFF246BFD);
  static const background = Color(0xFFF3F7FC);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: blue,
      brightness: Brightness.light,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamilyFallback: const ['PingFang SC', 'Noto Sans CJK SC'],
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: ink,
          fontSize: 44,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.8,
        ),
        headlineMedium: TextStyle(
          color: ink,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        titleLarge: TextStyle(
          color: ink,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(color: ink, fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(color: Color(0xFF5F6B85), height: 1.45),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Color(0xFF8A94A9)),
        prefixIconColor: const Color(0xFF5F6B85),
        suffixIconColor: const Color(0xFF5F6B85),
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
          borderSide: const BorderSide(color: Color(0xFFE6ECF5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: blue, width: 1.5),
        ),
      ),
    );
  }
}
