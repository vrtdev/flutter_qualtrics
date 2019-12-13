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

  /// TODO(jeremie-movify): add documentation
  Future<bool> display() async {
    await _init();
    return _channel.invokeMethod('display');
  }

  /// TODO(jeremie-movify): add documentation
  Future<void> displayTarget(String target) async {
    assert(target != null);
    await _init();
    return _channel.invokeMethod('displayTarget', {'target': target});
  }

  /// TODO(jeremie-movify): add documentation
  Future<bool> hide() async {
    await _init();
    return _channel.invokeMethod('hide');
  }

  /// TODO(jeremie-movify): add documentation
  Future<void> registerViewVisit(String viewName) async {
    assert(viewName != null);
    await _init();
    return _channel.invokeMethod('registerViewVisit', {'viewName': viewName});
  }

  /// TODO(jeremie-movify): add documentation
  Future<void> resetTimer() async {
    await _init();
    return _channel.invokeMethod('resetTimer');
  }

  /// TODO(jeremie-movify): add documentation
  Future<void> resetViewCounter() async {
    await _init();
    return _channel.invokeMethod('resetViewCounter');
  }
}
