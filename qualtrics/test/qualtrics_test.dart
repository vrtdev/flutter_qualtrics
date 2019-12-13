import 'package:flutter_test/flutter_test.dart';
import 'package:qualtrics/qualtrics.dart';
import 'package:mockito/mockito.dart';

import 'mocks/mocks.dart';

void main() {
  Qualtrics sut;
  MethodChannelMock methodChannelMock;

  setUp(() {
    methodChannelMock = MethodChannelMock();
    sut = Qualtrics.testable(methodChannelMock);
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('Initialization', () async {
    sut.initialize(brandId: 'testBrandId', zoneId: 'testZoneId', interceptId: 'testInterceptId');
    verify(methodChannelMock.invokeMethod('init', {
      'brandId': 'testBrandId',
      'zoneId': 'testZoneId',
      'interceptId': 'testInterceptId',
    }));
  });
}
