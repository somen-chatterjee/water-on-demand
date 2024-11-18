import 'package:flutter/foundation.dart';
import 'dart:async';

class BaseDeBouncer {
  final int? seconds;
  Timer? timer;

  BaseDeBouncer({this.timer, this.seconds});

  run(VoidCallback action) {
    timer?.cancel();
    timer = Timer(Duration(seconds: seconds??1), action);
  }
}