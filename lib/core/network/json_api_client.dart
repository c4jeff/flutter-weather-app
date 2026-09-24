import 'package:dio/dio.dart';

import 'package:weather_app/core/config/app_durations.dart';
import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/core/error/app_exception.dart';
import 'package:weather_app/core/network/dio_error_interceptor.dart';

class JsonApiClient {
  JsonApiClient({Dio? dio, List<Interceptor> interceptors = const []})
    : _dio = dio ?? _createDio() {
    _dio.interceptors.addAll([
      JsonRequestInterceptor(),
      DioErrorInterceptor(),
      ...interceptors,
    ]);
  }

  final Dio _dio;

  Future<Map<String, dynamic>> get(
    Uri uri, {
    Duration timeout = AppDurations.networkRequestTimeout,
    RequestCancellation? cancellation,
  }) async {
    try {
      final cancelToken = cancellation == null ? null : CancelToken();
      if (cancellation != null) {
        if (cancellation.isCancelled) {
          cancelToken!.cancel();
        } else {
          cancellation.whenCancelled.then((_) => cancelToken!.cancel());
        }
      }
      final response = await _dio.getUri<Object?>(
        uri,
        cancelToken: cancelToken,
        options: Options(
          connectTimeout: timeout,
          receiveTimeout: timeout,
          sendTimeout: timeout,
          responseType: ResponseType.json,
        ),
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const AppException(AppExceptionCode.expectedJsonObject);
      }
      return data;
    } on DioException catch (error, stackTrace) {
      final cause = error.error;
      if (cause is AppException) {
        Error.throwWithStackTrace(cause, error.stackTrace);
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  void close() => _dio.close(force: true);

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: AppDurations.networkRequestTimeout,
        receiveTimeout: AppDurations.networkRequestTimeout,
        sendTimeout: AppDurations.networkRequestTimeout,
        responseType: ResponseType.json,
      ),
    );
  }
}
