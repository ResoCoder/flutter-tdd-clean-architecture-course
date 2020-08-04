import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart' as data;

class MockDataConnectionChecker extends Mock
    implements data.DataConnectionChecker {}

extension MockDataConnectionCheckerExtension on MockDataConnectionChecker {
  void setupHasConnection() {
    when(hasConnection).thenAnswer((_) async => true);
  }

  void setupNoConnection() {
    when(hasConnection).thenAnswer((_) async => false);
  }
}
