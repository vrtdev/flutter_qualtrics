import 'dart:async';

import 'package:flutter/services.dart';

class Qualtrics {
  static const MethodChannel _channel =
      const MethodChannel('qualtrics');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
