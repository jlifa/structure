import 'dart:async';
import 'dart:ui';

class Debouncer {
  final int? milliseconds;
  late VoidCallback action;
  late Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}