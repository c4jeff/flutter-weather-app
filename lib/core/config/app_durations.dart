/// Shared timeout and interaction timing policy for the app.
abstract final class AppDurations {
  static const searchDebounce = Duration(milliseconds: 350);
  static const weatherContentTransition = Duration(milliseconds: 260);
  static const loadingPulse = Duration(milliseconds: 900);
  static const networkRequestTimeout = Duration(seconds: 12);
}
