/// Runtime API endpoints used by the app.
abstract final class ApiEndpoints {
  static final Uri locationSearch = Uri.https(
    'geocoding-api.open-meteo.com',
    '/v1/search',
  );

  static final Uri weatherForecast = Uri.https(
    'api.open-meteo.com',
    '/v1/forecast',
  );
}
