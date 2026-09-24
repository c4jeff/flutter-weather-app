import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/use_cases/get_weather_forecast.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/value_objects/weather_request.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => throw UnimplementedError(),
);

final getWeatherForecastProvider = Provider<GetWeatherForecast>(
  (ref) => GetWeatherForecast(ref.watch(weatherRepositoryProvider)),
);

final weatherProvider = FutureProvider.autoDispose
    .family<WeatherForecast, WeatherRequest>((ref, request) {
      final cancellation = RequestCancellation();
      ref.onDispose(cancellation.cancel);
      return ref
          .watch(getWeatherForecastProvider)
          .call(request, cancellation: cancellation);
    });
