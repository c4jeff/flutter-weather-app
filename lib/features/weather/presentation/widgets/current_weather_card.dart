import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../location/domain/location.dart';
import '../../domain/weather.dart';
import 'weather_visual.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({
    required this.location,
    required this.forecast,
    super.key,
  });

  final Location location;
  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
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
              ? const [Color(0xFF1E75F2), Color(0xFF65B8FA)]
              : const [Color(0xFF17294D), Color(0xFF344A7B)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: (isDay ? const Color(0xFF246BFD) : const Color(0xFF17294D))
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
                      location.name,
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
                location.subtitle,
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
                current.condition.label,
                style: const TextStyle(
                  color: foreground,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '体感 ${current.apparentTemperature.round()}°  ·  '
                '最高 ${today.maximumTemperature.round()}°  '
                '最低 ${today.minimumTemperature.round()}°',
                style: TextStyle(
                  color: foreground.withValues(alpha: 0.9),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '${DateFormat('M月d日 HH:mm').format(current.observedAt)} 更新',
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
