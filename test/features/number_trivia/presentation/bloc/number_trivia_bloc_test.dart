import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../lib/core/error/failures.dart';
import '../../../../../lib/core/usecases/usecase.dart';
import '../../../../../lib/core/util/input_converter.dart';
import '../../../../../lib/features/number_trivia/domain/entities/number_trivia.dart';
import '../../../../../lib/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import '../../../../../lib/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import '../../../../../lib/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import '../../../../../lib/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import '../../../../../lib/features/number_trivia/presentation/bloc/number_trivia_state.dart';

class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main () {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp((){
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia, 
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
       );
  });
  
  test('initialState should be Empty', () {
        expect(bloc.initialState, equals(Empty()));
  }); 

  group('GetTriviaForConcreteNumber', (){
    final tNumberString = '1'; // The event takes in String
    final tNumberParsed = 1;   // Successful Output of the InputConverter
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
      when(mockInputConverter.stringToPositiveInteger(any))
         .thenReturn(Right(tNumberParsed));

         test(
           'Should call the InputConverter to validate and convert the string to a positive integer',
           () async {
             setUpMockInputConverterSuccess();
             bloc.add(GetTriviaForConcreteNumber(tNumberString));
             await untilCalled(mockInputConverter.stringToPositiveInteger(any));
             verify(mockInputConverter.stringToPositiveInteger(tNumberString));
           },
         ); 

         test (
           'should emit [Error] when the input is invalid',
           () async {
              when(mockInputConverter.stringToPositiveInteger(any))
               .thenReturn(Left(InvalidInputFailure()));

              final expected = [
                Error(message: INVALID_INPUT_FAILURE_MESSAGE),
              ];
              expect(bloc.state, Empty());
              expectLater(bloc, emitsInOrder(expected));
              bloc.add(GetTriviaForConcreteNumber(tNumberString));
           },
         );  

         test (
           'Should get data from the concrete use case',
           () async {
             setUpMockInputConverterSuccess();
             when(mockGetConcreteNumberTrivia(any))
             .thenAnswer((_) async => Right(tNumberTrivia));
            bloc.add(GetTriviaForConcreteNumber(tNumberString));
            await untilCalled(mockGetConcreteNumberTrivia(any));
            verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
           },
         ); 

         test(
           'Should emit [Loading, Loaded] when data is gotten successfully',
           () async {
             setUpMockInputConverterSuccess();
             when(mockGetConcreteNumberTrivia(any))
             .thenAnswer((_) async => Right(tNumberTrivia));
               final expected = [
               Loading(),
               Loaded(trivia: tNumberTrivia),
             ];
             expect(bloc.state, Empty());
             expectLater(bloc, emitsInOrder(expected));
             bloc.add(GetTriviaForConcreteNumber(tNumberString));
           }
         );

         // Server Failure Test 
         test(
           'Should emit [Loading, Error] when getting data fails',
           () async {
             setUpMockInputConverterSuccess();
             when(mockGetConcreteNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));

              final expected = [
                Loading(),
                Error(message: SERVER_FAILURE_MESSAGE),
              ];
              expect(bloc.state, Empty());
              expectLater(bloc, emitsInOrder(expected));
              bloc.add(GetTriviaForConcreteNumber(tNumberString));
           }
         );

          // Cache Failure Test
         test(
           'Should emit [Loading, Error] with a proper message for the error when getting data fails',
           () async {
             setUpMockInputConverterSuccess();
             when(mockGetConcreteNumberTrivia(any))
               .thenAnswer((_) async => Left(CacheFailure()));
               final expected = [
                 Loading(),
                 Error(message: CACHE_FAILURE_MESSAGE),
               ];
               expect(bloc.state, Empty());
               expectLater(bloc, emitsInOrder(expected));
               bloc.add(GetTriviaForConcreteNumber(tNumberString));
           }
         );
  });

  group('GetTriviaForRandomNumber',(){
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
       test(
         'Should get data from the random use case',
         () async {
           when(mockGetRandomNumberTrivia(any))
             .thenAnswer((_) async => Right(tNumberTrivia));
             bloc.add(GetTriviaForRandomNumber());
             await untilCalled(mockGetRandomNumberTrivia(any()));
             verify(mockGetRandomNumberTrivia(NoParams()));
         }
       );
       test(
         'Should emit [Loading, Loaded] when data is gotten successfully',
          () async {
         when(mockGetRandomNumberTrivia(any))
         .thenAnswer((_) async => Right(tNumberTrivia));
         final expected = [
           Loading(),
           Loaded(trivia: tNumberTrivia),
         ];
         expect(bloc.state, equals(Empty()));
         expectLater(bloc, emitsInOrder(expected));
         bloc.add(GetTriviaForRandomNumber());
       });

       test(
         'Should emit [Loading, Error] when getting data fails', 
         () async {
            when(mockGetRandomNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));
            final expected = [
              Loading(),
              Error(message: SERVER_FAILURE_MESSAGE),
            ];
            expect(bloc.state, equals(Empty()));    
            expectLater(bloc, emitsInOrder(expected));
            bloc.add(GetTriviaForRandomNumber());
       });
       
       test(
         'Should emit [Loading, Error] with a proper message for the error when getting data fails',
          () async {
              when(mockGetRandomNumberTrivia(any))
               .thenAnswer((_) async => Left(CacheFailure()));
                final expected = [
                  Loading(),
                  Error(message: CACHE_FAILURE_MESSAGE),
                ];
                expect(bloc.state, Empty());
                expectLater(bloc, emitsInOrder(expected));
                bloc.add(GetTriviaForRandomNumber());

       });
  }
  );




}