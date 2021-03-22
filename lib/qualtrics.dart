import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class Qualtrics {
  final String brandId;
  final String zoneId;
  final String interceptId;

  final MethodChannel _channel;

  Future<void>? _initialization;

  Qualtrics({required this.brandId, required this.zoneId, required this.interceptId})
      : this._channel = const MethodChannel('flutter_qualtrics');

  @visibleForTesting
  Qualtrics.testable(this._channel, {required this.brandId, required this.zoneId, required this.interceptId});

  Future<void> _init() async => _initialization ??=
      _channel.invokeMethod('init', {'brandId': brandId, 'zoneId': zoneId, 'interceptId': interceptId});

  /// Causes the Qualtrics framework to evaluate the intercept's logic asynchronously.
  Future<bool> evaluateTargetingLogic() async {
    await _init();
    return await _channel.invokeMethod('evaluateTargetingLogic');
  }

  /// Displays the specified creative in the specified view controller.
  /// Typically, you need to evaluate whether the creative should be displayed
  /// by evaluating an intercept's logic using the
  /// evaluateTargetingLogicWithCompletion method.
  Future<bool> display() async {
    await _init();
    return await _channel.invokeMethod('display');
  }

  /// Displays the survey from the URL when the view controller was initialized.
  Future<void> displayTarget(String target) async {
    await _init();
    return await _channel.invokeMethod('displayTarget', {'target': target});
  }

  ///
  Future<bool> hide() async {
    await _init();
    return await _channel.invokeMethod('hide');
  }

  /// Records a visit to a particular view.
  Future<void> registerViewVisit(String viewName) async {
    await _init();
    return await _channel.invokeMethod('registerViewVisit', {'viewName': viewName});
  }

  /// Resets the usage timer that is available to the intercept on the server
  /// as Time Spent in App.
  Future<void> resetTimer() async {
    await _init();
    return await _channel.invokeMethod('resetTimer');
  }

  /// Resets the view count to zero. It is available to the intercept as the
  /// View Count value in the intercept display logic.
  Future<void> resetViewCounter() async {
    await _init();
    return await _channel.invokeMethod('resetViewCounter');
  }

  /// Records custom embedded string data properties to support advanced intercepts logic.
  Future<void> setStringProperty(String key, String value) async {
    await _init();
    return await _channel.invokeMethod('setStringProperty', {'key': key, 'value': value});
  }

  /// Records custom embedded number data properties to support advanced intercepts logic.
  Future<void> setNumberProperty(String key, double value) async {
    assert(key != null);
    assert(value != null);
    await _init();
    return _channel.invokeMethod('setNumberProperty', {'key': key, 'value': value});
  }
}
