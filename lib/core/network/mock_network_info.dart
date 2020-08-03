import 'network_info.dart';

class MockNetworkInfoImpl implements NetworkInfo {
  MockNetworkInfoImpl();

  @override
  Future<bool> get isConnected =>
      Future.delayed(Duration(seconds: 1), () => true);
}
