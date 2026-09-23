import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../location/domain/location.dart';
import '../../location/presentation/location_providers.dart';
import '../../location/presentation/widgets/location_search_field.dart';
import '../domain/weather.dart';
import 'weather_providers.dart';
import 'widgets/current_weather_card.dart';
import 'widgets/daily_forecast_list.dart';
import 'widgets/weather_detail_grid.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(selectedLocationProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 980),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _PageHeader(),
                        const SizedBox(height: 24),
                        LocationSearchField(
                          onSelected: (value) => ref
                              .read(selectedLocationProvider.notifier)
                              .select(value),
                        ),
                        const SizedBox(height: 28),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 260),
                          child: location == null
                              ? const _InitialState(
                                  key: ValueKey('initial-state'),
                                )
                              : _WeatherState(
                                  key: ValueKey(location.id),
                                  location: location,
                                ),
                        ),
                        const SizedBox(height: 28),
                        const _Attribution(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF246BFD), Color(0xFF62B6F8)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.cloud_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('晴雨间', style: Theme.of(context).textTheme.titleLarge),
            Text('查找城市，了解天气', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}

class _InitialState extends StatelessWidget {
  const _InitialState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE6ECF5)),
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF2FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.travel_explore_rounded,
              color: Color(0xFF246BFD),
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text('从一个地点开始', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            '在上方搜索城市，即可查看当前天气和未来 7 天预报。',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _WeatherState extends ConsumerWidget {
  const _WeatherState({required this.location, super.key});

  final Location location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider(location));

    return weather.when(
      loading: () => const LoadingSkeleton(),
      error: (error, stackTrace) => Card(
        child: AppErrorView(
          message: userMessageFor(error),
          onRetry: () => ref.invalidate(weatherProvider(location)),
        ),
      ),
      data: (forecast) =>
          _WeatherContent(location: location, forecast: forecast),
    );
  }
}

class _WeatherContent extends StatelessWidget {
  const _WeatherContent({required this.location, required this.forecast});

  final Location location;
  final WeatherForecast forecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CurrentWeatherCard(location: location, forecast: forecast),
        const SizedBox(height: 18),
        WeatherDetailGrid(forecast: forecast),
        const SizedBox(height: 30),
        Text('未来 7 天', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
        DailyForecastList(days: forecast.daily),
      ],
    );
  }
}

class _Attribution extends StatelessWidget {
  const _Attribution();

  @override
  Widget build(BuildContext context) {
    return Text(
      '天气数据由 Open-Meteo 提供',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
    );
  }
}
