import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getYearNumberTrivia(
      int number); // year trivia
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
