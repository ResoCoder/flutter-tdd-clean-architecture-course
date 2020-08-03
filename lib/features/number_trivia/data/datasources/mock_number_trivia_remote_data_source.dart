import 'dart:math';
import '../models/number_trivia_model.dart';
import 'number_trivia_remote_data_source.dart';

class MockNumberTriviaRemoteDataSourceImpl
    implements NumberTriviaRemoteDataSource {
  MockNumberTriviaRemoteDataSourceImpl();

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    var model =
        NumberTriviaModel(number: number, text: '$number is a cool number.');
    return delayedResponse(model);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    var randomNum = Random().nextInt(100);
    var model = NumberTriviaModel(
        number: randomNum, text: '$randomNum is a cool number.');
    return delayedResponse(model);
  }

  Future<NumberTriviaModel> delayedResponse(NumberTriviaModel model) {
    return Future.delayed(Duration(seconds: 2), () {
      return model;
    });
  }
}
