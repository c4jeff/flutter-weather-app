import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../error/app_exception.dart';

class JsonApiClient {
  JsonApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Map<String, dynamic>> get(
    Uri uri, {
    Duration timeout = const Duration(seconds: 12),
  }) async {
    try {
      final response = await _client.get(uri).timeout(timeout);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw AppException(
          AppErrorKind.service,
          'Request failed',
          statusCode: response.statusCode,
        );
      }

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is! Map<String, dynamic>) {
        throw const AppException(
          AppErrorKind.invalidData,
          'Expected a JSON object',
        );
      }
      return decoded;
    } on TimeoutException {
      throw const AppException(AppErrorKind.timeout, 'Request timed out');
    } on SocketException {
      throw const AppException(AppErrorKind.network, 'Network unavailable');
    } on http.ClientException {
      throw const AppException(AppErrorKind.network, 'Network request failed');
    } on FormatException {
      throw const AppException(AppErrorKind.invalidData, 'Invalid JSON');
    }
  }
}
