import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/app/weather_app.dart';
import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:weather_app/features/location/presentation/providers/location_providers.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/value_objects/weather_request.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_providers.dart';

void main() {
  testWidgets('searching and selecting a city displays its weather', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          locationRepositoryProvider.overrideWithValue(
            _FakeLocationRepository(),
          ),
          weatherRepositoryProvider.overrideWithValue(_FakeWeatherRepository()),
        ],
        child: const WeatherApp(),
      ),
    );

    expect(find.text('Start with a location'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('location-search-field')),
      '上海',
    );
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('上海市 · 中国'), findsOneWidget);
    await tester.tap(find.text('上海市 · 中国'));
    await tester.pumpAndSettle();

    expect(find.text('24°'), findsOneWidget);
    expect(find.text('Partly clear'), findsOneWidget);
    expect(find.text('7-day forecast'), findsOneWidget);
  });
}

const _location = Location(
  id: 1796236,
  name: '上海',
  latitude: 31.22,
  longitude: 121.46,
  country: '中国',
  adminArea: '上海市',
  timezone: 'Asia/Shanghai',
);

class _FakeLocationRepository implements LocationRepository {
  @override
  Future<List<Location>> search(
    String query, {
    required String language,
    RequestCancellation? cancellation,
  }) async => const [_location];
}

class _FakeWeatherRepository implements WeatherRepository {
  @override
  Future<WeatherForecast> getForecast(
    WeatherRequest request, {
    RequestCancellation? cancellation,
  }) async {
    return WeatherForecast(
      current: CurrentWeather(
        temperature: 23.6,
        apparentTemperature: 24.1,
        humidity: 65,
        windSpeed: 12.5,
        precipitation: 0,
        condition: WeatherCondition.mostlyClear,
        isDay: true,
        observedAt: DateTime(2026, 9, 23, 14),
      ),
      daily: List.generate(
        7,
        (index) => DailyForecast(
          date: DateTime(2026, 9, 23 + index),
          condition: WeatherCondition.mostlyClear,
          minimumTemperature: 18,
          maximumTemperature: 28,
          precipitationProbability: 20,
        ),
      ),
      temperatureUnit: '°C',
      windSpeedUnit: 'km/h',
      precipitationUnit: 'mm',
      timezone: 'Asia/Shanghai',
    );
  }
}
