import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/json_api_client.dart';
import 'package:weather_app/features/location/data/repositories/open_meteo_location_repository.dart';

void main() {
  test('searches with a normalized query and maps locations', () async {
    late Uri requestedUri;
    final dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requestedUri = options.uri;
            handler.resolve(
              Response(
                requestOptions: options,
                statusCode: 200,
                data: {
                  'results': [
                    {
                      'id': 1796236,
                      'name': '上海',
                      'latitude': 31.22222,
                      'longitude': 121.45806,
                      'country': '中国',
                      'admin1': '上海市',
                      'timezone': 'Asia/Shanghai',
                    },
                  ],
                },
              ),
            );
          },
        ),
      );
    final apiClient = JsonApiClient(dio: dio);
    addTearDown(apiClient.close);
    final repository = OpenMeteoLocationRepository(apiClient);

    final locations = await repository.search('  上海  ', language: 'zh');

    expect(requestedUri.queryParameters['name'], '上海');
    expect(requestedUri.queryParameters['language'], 'zh');
    expect(locations.single.name, '上海');
    expect(locations.single.subtitle, '上海市 · 中国');
  });
}
