import 'package:flutter_test/flutter_test.dart';
import 'package:qualtrics/qualtrics.dart';
import 'package:mockito/mockito.dart';

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
}
