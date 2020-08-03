import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../test/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

extension MockHttpClientExtension on MockHttpClient {
  void setUpMockHttpClientSuccess200() {
    when(get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
}
