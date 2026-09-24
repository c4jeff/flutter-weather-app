import 'package:flutter/material.dart';

/// Semantic color palette shared across the weather app.
abstract final class WeatherColors {
  // Brand and surfaces.
  static const primary = Color(0xFF246BFD);
  static const primaryLight = Color(0xFF62B6F8);
  static const appBackground = Color(0xFFF3F7FC);
  static const cardBorder = Color(0xFFE6ECF5);
  static const accentSurface = Color(0xFFEAF2FF);

  // Text and controls.
  static const textPrimary = Color(0xFF16213A);
  static const textStrong = Color(0xFF17213A);
  static const textSecondary = Color(0xFF5F6B85);
  static const textMuted = Color(0xFF8A94A9);
  static const iconMuted = Color(0xFF77829A);

  // Current weather card gradients.
  static const dayWeatherStart = Color(0xFF1E75F2);
  static const dayWeatherEnd = Color(0xFF65B8FA);
  static const nightWeatherStart = Color(0xFF17294D);
  static const nightWeatherEnd = Color(0xFF344A7B);

  // Loading placeholder.
  static const skeletonStart = Color(0xFFE3EAF4);
  static const skeletonEnd = Color(0xFFF2F6FB);

  // Weather condition accents.
  static const sunny = Color(0xFFFFB21A);
  static const partlyCloudy = Color(0xFF76A9FA);
  static const cloudy = Color(0xFF76849F);
  static const fog = textMuted;
  static const precipitation = Color(0xFF367DEC);
  static const snow = Color(0xFF79B8D1);
  static const thunderstorm = Color(0xFF7656B5);
}
