enum AppErrorKind { network, timeout, service, invalidData, unknown }

class AppException implements Exception {
  const AppException(this.kind, this.message, {this.statusCode});

  final AppErrorKind kind;
  final String message;
  final int? statusCode;

  @override
  String toString() => 'AppException($kind, $message, status: $statusCode)';
}

String userMessageFor(Object error) {
  if (error is AppException) {
    return switch (error.kind) {
      AppErrorKind.network => '无法连接到天气服务，请检查网络后重试。',
      AppErrorKind.timeout => '请求超时，请稍后重试。',
      AppErrorKind.service => '天气服务暂时不可用，请稍后重试。',
      AppErrorKind.invalidData => '天气数据不完整，请重新加载。',
      AppErrorKind.unknown => '出现了意外问题，请稍后重试。',
    };
  }
  return '出现了意外问题，请稍后重试。';
}
