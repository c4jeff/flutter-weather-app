import 'package:flutter/material.dart';

import 'package:weather_app/app/theme/weather_colors.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

class WeatherDetailGrid extends StatelessWidget {
  const WeatherDetailGrid({required this.forecast, super.key});

  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final current = forecast.current;
    final details = [
      _Detail(
        icon: Icons.water_drop_outlined,
        label: l10n.humidity,
        value: '${current.humidity}%',
      ),
      _Detail(
        icon: Icons.air_rounded,
        label: l10n.windSpeed,
        value: '${_number(current.windSpeed)} ${forecast.windSpeedUnit}',
      ),
      _Detail(
        icon: Icons.umbrella_outlined,
        label: l10n.precipitation,
        value:
            '${_number(current.precipitation)} ${forecast.precipitationUnit}',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 520;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: details.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: narrow ? 1 : 3,
            mainAxisExtent: 96,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final detail = details[index];
            return Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: WeatherColors.accentSurface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(detail.icon, color: WeatherColors.primary),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.label,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            detail.value,
                            style: const TextStyle(
                              color: WeatherColors.textStrong,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _number(double value) {
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(1);
  }
}

class _Detail {
  const _Detail({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;
}
