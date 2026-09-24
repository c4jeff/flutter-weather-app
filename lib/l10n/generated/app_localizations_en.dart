// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Weather Between';

  @override
  String get appTagline => 'Find a city and check the weather';

  @override
  String get searchLocationHint => 'Search a city, e.g. Shanghai or Tokyo';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get enterMoreCharacters => 'Enter at least one more character';

  @override
  String get retry => 'Retry';

  @override
  String get reload => 'Reload';

  @override
  String get noLocationsFound => 'No matching locations found';

  @override
  String get loadingWeather => 'Loading weather';

  @override
  String get networkError =>
      'Could not connect to the weather service. Check your connection and try again.';

  @override
  String get timeoutError => 'The request timed out. Please try again.';

  @override
  String get serviceError =>
      'The weather service is temporarily unavailable. Please try again later.';

  @override
  String get invalidWeatherDataError =>
      'Weather data is incomplete. Please reload.';

  @override
  String get unexpectedError => 'Something went wrong. Please try again later.';

  @override
  String get initialTitle => 'Start with a location';

  @override
  String get initialDescription =>
      'Search for a city above to see current conditions and the 7-day forecast.';

  @override
  String get forecastTitle => '7-day forecast';

  @override
  String get weatherDataAttribution => 'Weather data provided by Open-Meteo';

  @override
  String get humidity => 'Humidity';

  @override
  String get windSpeed => 'Wind speed';

  @override
  String get precipitation => 'Precipitation';

  @override
  String get today => 'Today';

  @override
  String get feelsLike => 'Feels like';

  @override
  String get maximum => 'High';

  @override
  String get minimum => 'Low';

  @override
  String get updated => 'Updated';

  @override
  String currentWeatherSummary(
    int apparentTemperature,
    int maximumTemperature,
    int minimumTemperature,
  ) {
    return 'Feels like $apparentTemperature° · High $maximumTemperature°  Low $minimumTemperature°';
  }

  @override
  String weatherUpdatedAt(Object formattedDate) {
    return 'Updated $formattedDate';
  }

  @override
  String get clear => 'Clear';

  @override
  String get mostlyClear => 'Mostly clear';

  @override
  String get cloudy => 'Cloudy';

  @override
  String get fog => 'Fog';

  @override
  String get drizzle => 'Drizzle';

  @override
  String get rain => 'Rain';

  @override
  String get snow => 'Snow';

  @override
  String get shower => 'Showers';

  @override
  String get thunderstorm => 'Thunderstorm';

  @override
  String get unknownWeather => 'Unknown';
}
