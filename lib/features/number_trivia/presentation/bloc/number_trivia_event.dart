import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
