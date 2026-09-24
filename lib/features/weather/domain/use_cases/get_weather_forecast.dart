import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/value_objects/weather_request.dart';

class GetWeatherForecast {
  const GetWeatherForecast(this._repository);

  final WeatherRepository _repository;

  Future<WeatherForecast> call(
    WeatherRequest request, {
    RequestCancellation? cancellation,
  }) {
    return _repository.getForecast(request, cancellation: cancellation);
  }
}
