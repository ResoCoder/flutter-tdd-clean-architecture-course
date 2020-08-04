import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

String _json = ''' {
  "text": "Test Text",
  "number": 1,
  "found": true,
  "type": "trivia"
} ''';

extension MockHttpClientExtension on MockHttpClient {
  void setUpGetSuccess200() {
    when(get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(_json, 200));
  }

  void setUpGetFailure404() {
    when(get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
}
