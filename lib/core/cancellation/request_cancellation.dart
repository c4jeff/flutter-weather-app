import 'dart:async';

/// A small cancellation signal that keeps UI and domain layers independent
/// from the HTTP client's cancellation mechanism.
class RequestCancellation {
  final Completer<void> _completer = Completer<void>();

  bool get isCancelled => _completer.isCompleted;

  Future<void> get whenCancelled => _completer.future;

  void cancel() {
    if (!_completer.isCompleted) _completer.complete();
  }
}
