import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class Qualtrics {
  final String brandId;
  final String zoneId;
  final String interceptId;

  final MethodChannel _channel;

  Future<void> _initialization;

  Qualtrics({@required this.brandId, @required this.zoneId, @required this.interceptId})
      : this._channel = const MethodChannel('vrt_qualtrics');

  @visibleForTesting
  Qualtrics.testable(this._channel, {@required this.brandId, @required this.zoneId, @required this.interceptId});

  Future<void> _init() async => _initialization ??=
      _channel.invokeMethod('init', {'brandId': brandId, 'zoneId': zoneId, 'interceptId': interceptId});

  /// Causes the Qualtrics framework to evaluate the intercept's logic asynchronously.
  Future<bool> evaluateTargetingLogic() async {
    await _init();
    return _channel.invokeMethod('evaluateTargetingLogic');
  }
}
