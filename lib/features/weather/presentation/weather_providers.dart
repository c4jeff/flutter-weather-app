import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../location/domain/location.dart';
import '../../location/presentation/location_providers.dart';
import '../data/weather_repository.dart';
import '../domain/weather.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => WeatherRepository(ref.watch(apiClientProvider)),
);

final weatherProvider = FutureProvider.autoDispose
    .family<WeatherForecast, Location>((ref, location) {
      return ref.watch(weatherRepositoryProvider).getForecast(location);
    });
