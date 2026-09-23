import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:weather_app/core/network/json_api_client.dart';
import 'package:weather_app/features/location/data/location_repository.dart';

void main() {
  test('searches with a normalized query and maps locations', () async {
    late Uri requestedUri;
    final client = MockClient((request) async {
      requestedUri = request.url;
      return http.Response.bytes(
        utf8.encode(
          jsonEncode({
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
          }),
        ),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    final repository = LocationRepository(JsonApiClient(client: client));

    final locations = await repository.search('  上海  ');

    expect(requestedUri.queryParameters['name'], '上海');
    expect(requestedUri.queryParameters['language'], 'zh');
    expect(locations.single.name, '上海');
    expect(locations.single.subtitle, '上海市 · 中国');
  });
}
