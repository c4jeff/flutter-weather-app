import 'package:weather_app/core/network/network_providers.dart';
import 'package:weather_app/features/location/data/repositories/open_meteo_location_repository.dart';
import 'package:weather_app/features/location/presentation/providers/location_providers.dart';
import 'package:weather_app/features/weather/data/repositories/open_meteo_weather_repository.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_providers.dart';

/// Application composition root: connects domain contracts to data sources.
final appProviderOverrides = [
  locationRepositoryProvider.overrideWith(
    (ref) => OpenMeteoLocationRepository(ref.watch(apiClientProvider)),
  ),
  weatherRepositoryProvider.overrideWith(
    (ref) => OpenMeteoWeatherRepository(ref.watch(apiClientProvider)),
  ),
];
