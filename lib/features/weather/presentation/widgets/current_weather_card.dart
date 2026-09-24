import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/app/theme/weather_colors.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/formatters/weather_condition_label.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_visual.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({
    required this.locationName,
    required this.locationSubtitle,
    required this.forecast,
    super.key,
  });

  final String locationName;
  final String locationSubtitle;
  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeName = l10n.localeName;
    final current = forecast.current;
    final today = forecast.daily.first;
    final isDay = current.isDay;
    const foreground = Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDay
              ? const [
                  WeatherColors.dayWeatherStart,
                  WeatherColors.dayWeatherEnd,
                ]
              : const [
                  WeatherColors.nightWeatherStart,
                  WeatherColors.nightWeatherEnd,
                ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color:
                (isDay
                        ? WeatherColors.primary
                        : WeatherColors.nightWeatherStart)
                    .withValues(alpha: 0.22),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: 18,
            child: Icon(
              iconForWeather(current.condition),
              size: 142,
              color: foreground.withValues(alpha: 0.24),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: foreground),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      locationName,
                      style: const TextStyle(
                        color: foreground,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                locationSubtitle,
                style: TextStyle(color: foreground.withValues(alpha: 0.78)),
              ),
              const SizedBox(height: 34),
              Text(
                '${current.temperature.round()}°',
                style: const TextStyle(
                  color: foreground,
                  fontSize: 74,
                  height: 0.95,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                current.condition.labelFor(l10n),
                style: const TextStyle(
                  color: foreground,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.currentWeatherSummary(
                  current.apparentTemperature.round(),
                  today.maximumTemperature.round(),
                  today.minimumTemperature.round(),
                ),
                style: TextStyle(
                  color: foreground.withValues(alpha: 0.9),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.weatherUpdatedAt(
                  DateFormat.yMMMd(
                    localeName,
                  ).add_Hm().format(current.observedAt),
                ),
                style: TextStyle(
                  color: foreground.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
