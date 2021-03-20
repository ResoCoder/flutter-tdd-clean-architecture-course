import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

//  new useCase year trivia

class GetYearNumberTrivia implements UseCase<NumberTrivia, YearTrivia> {
  final NumberTriviaRepository repository;

  GetYearNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(YearTrivia params) async {
    return await repository.getYearNumberTrivia(params.number);
  }
}

class YearTrivia extends Equatable {
  final int number;

  YearTrivia({@required this.number});

  @override
  List<Object> get props => [number];
}
