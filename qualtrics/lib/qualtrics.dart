import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class Qualtrics {
  final MethodChannel _channel;

  Qualtrics() : this._channel = const MethodChannel('vrt_qualtrics');

  Qualtrics.testable(this._channel);

  void initialize({@required final brandId, @required final zoneId, @required final interceptId}) {
    _channel.invokeMethod('init', {'brandId': brandId, 'zoneId': zoneId, 'interceptId': interceptId});
  }
}
