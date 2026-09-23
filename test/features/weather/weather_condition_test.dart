import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/weather.dart';

void main() {
  test('maps representative WMO weather codes', () {
    expect(weatherConditionFromCode(0), WeatherCondition.clear);
    expect(weatherConditionFromCode(45), WeatherCondition.fog);
    expect(weatherConditionFromCode(63), WeatherCondition.rain);
    expect(weatherConditionFromCode(75), WeatherCondition.snow);
    expect(weatherConditionFromCode(95), WeatherCondition.thunderstorm);
    expect(weatherConditionFromCode(999), WeatherCondition.unknown);
  });
}
