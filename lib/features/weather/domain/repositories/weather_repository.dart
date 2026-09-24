import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/value_objects/weather_request.dart';

abstract interface class WeatherRepository {
  Future<WeatherForecast> getForecast(
    WeatherRequest request, {
    RequestCancellation? cancellation,
  });
}
