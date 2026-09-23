import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/weather.dart';
import 'weather_visual.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({required this.days, super.key});

  final List<DailyForecast> days;

  @override
  Widget build(BuildContext context) {
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
                      index == 0 ? '今天' : _weekday(day.date.weekday),
                      style: const TextStyle(
                        color: Color(0xFF17213A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      DateFormat('M月d日').format(day.date),
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
                        color: Color(0xFF17213A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.water_drop_rounded,
                          size: 13,
                          color: Color(0xFF367DEC),
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

  String _weekday(int weekday) {
    const labels = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return labels[weekday - 1];
  }
}
