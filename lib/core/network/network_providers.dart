import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/core/network/json_api_client.dart';

final apiInterceptorsProvider = Provider<List<Interceptor>>((ref) => const []);

final apiClientProvider = Provider<JsonApiClient>((ref) {
  final client = JsonApiClient(
    interceptors: ref.watch(apiInterceptorsProvider),
  );
  ref.onDispose(client.close);
  return client;
});
