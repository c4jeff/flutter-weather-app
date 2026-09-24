import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

extension WeatherConditionLabel on WeatherCondition {
  String labelFor(AppLocalizations l10n) => switch (this) {
    WeatherCondition.clear => l10n.clear,
    WeatherCondition.mostlyClear => l10n.mostlyClear,
    WeatherCondition.cloudy => l10n.cloudy,
    WeatherCondition.fog => l10n.fog,
    WeatherCondition.drizzle => l10n.drizzle,
    WeatherCondition.rain => l10n.rain,
    WeatherCondition.snow => l10n.snow,
    WeatherCondition.shower => l10n.shower,
    WeatherCondition.thunderstorm => l10n.thunderstorm,
    WeatherCondition.unknown => l10n.unknownWeather,
  };
}
