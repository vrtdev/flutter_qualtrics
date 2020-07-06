import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qualtrics_flutter/qualtrics.dart';

import 'mocks/mocks.dart';

void main() {
  Qualtrics sut;
  MethodChannelMock methodChannelMock;

  setUp(() {
    methodChannelMock = MethodChannelMock();
    sut = Qualtrics.testable(methodChannelMock,
        brandId: 'testBrandId', zoneId: 'testZoneId', interceptId: 'testInterceptId');
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  void _verifyInitializationMethodCalled() {
    verify(methodChannelMock
        .invokeMethod('init', {'brandId': 'testBrandId', 'zoneId': 'testZoneId', 'interceptId': 'testInterceptId'}));
  }

  test('Evaluate Targeting Logic', () async {
    await sut.evaluateTargetingLogic();
    _verifyInitializationMethodCalled();
    verify(methodChannelMock.invokeMethod('evaluateTargetingLogic'));
  });

  test('Display', () async {
    await sut.display();
    _verifyInitializationMethodCalled();
    verify(methodChannelMock.invokeMethod('display'));
  });

  test('Display Target', () async {
    await sut.displayTarget('testTarget');
    _verifyInitializationMethodCalled();
    verify(methodChannelMock.invokeMethod('displayTarget', {'target': 'testTarget'}));
  });

  test('Hide', () async {
    await sut.hide();
    _verifyInitializationMethodCalled();
    verify(methodChannelMock.invokeMethod('hide'));
  });

  test('Register View Visit', () async {
    await sut.registerViewVisit('testViewName');
    _verifyInitializationMethodCalled();
    verify(methodChannelMock.invokeMethod('registerViewVisit', {'viewName': 'testViewName'}));
  });

  test('Reset Timer', () async {
    await sut.resetTimer();
    _verifyInitializationMethodCalled();
    verify(methodChannelMock.invokeMethod('resetTimer'));
  });

  test('Reset View Counter', () async {
    await sut.resetViewCounter();
    _verifyInitializationMethodCalled();
    verify(methodChannelMock.invokeMethod('resetViewCounter'));
  });
}
