import 'package:weather_app/core/error/app_exception.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

/// Converts transport and data error categories into the current locale's copy.
String userMessageFor(AppLocalizations l10n, Object error) {
  if (error is AppException) {
    return switch (error.kind) {
      AppErrorKind.network => l10n.networkError,
      AppErrorKind.timeout => l10n.timeoutError,
      AppErrorKind.service => l10n.serviceError,
      AppErrorKind.invalidData => l10n.invalidWeatherDataError,
      AppErrorKind.unknown => l10n.unexpectedError,
    };
  }
  return l10n.unexpectedError;
}
