import 'package:clean_architecture_tdd_course/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_info_test.mocks.dart';

// class MockDataConnectionChecker extends Mock implements Connectivity {}

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange

        when(mockDataConnectionChecker.checkConnectivity())
            .thenAnswer((_) => Future.value(ConnectivityResult.mobile));

        // act
        final result = await networkInfo.isConnected;

        // assert
        verify(mockDataConnectionChecker.checkConnectivity());

        expect(result, true);
      },
    );
  });
}
