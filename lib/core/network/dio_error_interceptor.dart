import 'dart:io';

import 'package:dio/dio.dart';

import 'package:weather_app/core/error/app_exception.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapError(err);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
        message: err.message,
        stackTrace: err.stackTrace,
      ),
    );
  }

  AppException _mapError(DioException error) {
    if (error.error is AppException) return error.error! as AppException;

    final statusCode = error.response?.statusCode;
    if (error.type == DioExceptionType.badResponse && statusCode != null) {
      return AppException(
        AppExceptionCode.requestFailed,
        statusCode: statusCode,
      );
    }

    if (error.type
        case DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout ||
            DioExceptionType.receiveTimeout) {
      return const AppException(AppExceptionCode.requestTimedOut);
    }

    if (error.type == DioExceptionType.cancel) {
      return const AppException(AppExceptionCode.requestCancelled);
    }

    if (error.error is FormatException) {
      return const AppException(AppExceptionCode.invalidJson);
    }

    if (error.type == DioExceptionType.connectionError ||
        error.error is SocketException) {
      return const AppException(AppExceptionCode.networkUnavailable);
    }

    return const AppException(AppExceptionCode.unexpectedRequestFailure);
  }
}

class JsonRequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.putIfAbsent(
      Headers.acceptHeader,
      () => Headers.jsonContentType,
    );
    handler.next(options);
  }
}
