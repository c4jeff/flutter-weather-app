enum AppErrorKind { network, timeout, service, invalidData, unknown }

/// Stable diagnostic identifiers; user-facing text belongs in `l10n`.
enum AppExceptionCode {
  requestFailed(AppErrorKind.service),
  requestCancelled(AppErrorKind.unknown),
  unexpectedRequestFailure(AppErrorKind.unknown),
  expectedJsonObject(AppErrorKind.invalidData),
  requestTimedOut(AppErrorKind.timeout),
  networkUnavailable(AppErrorKind.network),
  invalidJson(AppErrorKind.invalidData),
  invalidLocationResults(AppErrorKind.invalidData),
  incompleteLocationData(AppErrorKind.invalidData),
  unableToParseWeatherResponse(AppErrorKind.invalidData),
  inconsistentDailyWeatherArrays(AppErrorKind.invalidData),
  expectedObject(AppErrorKind.invalidData),
  expectedList(AppErrorKind.invalidData),
  expectedText(AppErrorKind.invalidData),
  expectedNumber(AppErrorKind.invalidData);

  const AppExceptionCode(this.kind);

  final AppErrorKind kind;
}

class AppException implements Exception {
  const AppException(this.code, {this.statusCode});

  final AppExceptionCode code;
  final int? statusCode;

  AppErrorKind get kind => code.kind;

  @override
  String toString() => 'AppException($code, status: $statusCode)';
}
