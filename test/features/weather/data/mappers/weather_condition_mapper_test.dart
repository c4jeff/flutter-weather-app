import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/data/mappers/weather_mapper.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

void main() {
  test('maps representative WMO weather codes', () {
    expect(WeatherMapper.conditionFromCode(0), WeatherCondition.clear);
    expect(WeatherMapper.conditionFromCode(45), WeatherCondition.fog);
    expect(WeatherMapper.conditionFromCode(63), WeatherCondition.rain);
    expect(WeatherMapper.conditionFromCode(75), WeatherCondition.snow);
    expect(WeatherMapper.conditionFromCode(95), WeatherCondition.thunderstorm);
    expect(WeatherMapper.conditionFromCode(999), WeatherCondition.unknown);
  });
}
