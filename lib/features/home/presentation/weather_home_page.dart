import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/app/theme/weather_colors.dart';
import 'package:weather_app/shared/presentation/widgets/app_error_view.dart';
import 'package:weather_app/core/config/app_durations.dart';
import 'package:weather_app/l10n/app_error_messages.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/presentation/providers/location_providers.dart';
import 'package:weather_app/features/location/presentation/widgets/location_search_field.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/value_objects/weather_request.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_providers.dart';
import 'package:weather_app/features/weather/presentation/widgets/current_weather_card.dart';
import 'package:weather_app/features/weather/presentation/widgets/daily_forecast_list.dart';
import 'package:weather_app/features/weather/presentation/widgets/loading_skeleton.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_detail_grid.dart';

class WeatherHomePage extends ConsumerWidget {
  const WeatherHomePage({super.key});

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
                        _PageHeader(l10n: AppLocalizations.of(context)!),
                        const SizedBox(height: 24),
                        LocationSearchField(
                          onSelected: (value) => ref
                              .read(selectedLocationProvider.notifier)
                              .select(value),
                        ),
                        const SizedBox(height: 28),
                        AnimatedSwitcher(
                          duration: AppDurations.weatherContentTransition,
                          child: location == null
                              ? const _InitialState(
                                  key: ValueKey('initial-state'),
                                )
                              : _WeatherState(
                                  key: ValueKey(location.id),
                                  location: location,
                                  request: (
                                    latitude: location.latitude,
                                    longitude: location.longitude,
                                    timezone: location.timezone,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 28),
                        _Attribution(l10n: AppLocalizations.of(context)!),
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
  const _PageHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [WeatherColors.primary, WeatherColors.primaryLight],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.cloud_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.appName, style: Theme.of(context).textTheme.titleLarge),
            Text(
              l10n.appTagline,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: WeatherColors.cardBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: const BoxDecoration(
              color: WeatherColors.accentSurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.travel_explore_rounded,
              color: WeatherColors.primary,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.initialTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.initialDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _WeatherState extends ConsumerWidget {
  const _WeatherState({
    required this.location,
    required this.request,
    super.key,
  });

  final Location location;
  final WeatherRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherProvider(request));

    return weather.when(
      loading: () => const LoadingSkeleton(),
      error: (error, stackTrace) => Card(
        child: AppErrorView(
          message: userMessageFor(AppLocalizations.of(context)!, error),
          onRetry: () => ref.invalidate(weatherProvider(request)),
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CurrentWeatherCard(
          locationName: location.name,
          locationSubtitle: location.subtitle,
          forecast: forecast,
        ),
        const SizedBox(height: 18),
        WeatherDetailGrid(forecast: forecast),
        const SizedBox(height: 30),
        Text(l10n.forecastTitle, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 14),
        DailyForecastList(days: forecast.daily),
      ],
    );
  }
}

class _Attribution extends StatelessWidget {
  const _Attribution({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Text(
      l10n.weatherDataAttribution,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
    );
  }
}
