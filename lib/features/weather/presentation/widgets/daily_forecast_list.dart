import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/app/theme/weather_colors.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_visual.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({required this.days, super.key});

  final List<DailyForecast> days;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeName = l10n.localeName;
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final day = days[index];
          return SizedBox(
            width: 136,
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0
                          ? l10n.today
                          : DateFormat.EEEE(localeName).format(day.date),
                      style: const TextStyle(
                        color: WeatherColors.textStrong,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      DateFormat.MMMd(localeName).format(day.date),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    Icon(
                      iconForWeather(day.condition),
                      color: colorForWeather(day.condition),
                      size: 32,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${day.maximumTemperature.round()}°  '
                      '${day.minimumTemperature.round()}°',
                      style: const TextStyle(
                        color: WeatherColors.textStrong,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.water_drop_rounded,
                          size: 13,
                          color: WeatherColors.precipitation,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${day.precipitationProbability}%',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
