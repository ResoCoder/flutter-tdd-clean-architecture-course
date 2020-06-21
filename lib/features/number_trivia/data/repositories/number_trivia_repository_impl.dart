import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';

typedef Future<Either<Failure, T>> _ConcreteOrRandomChooser<T>();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _handleException(() {
      return saveToLocalCache(() => remoteDataSource.getConcreteNumberTrivia(number));
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _handleException(() {
      return saveToLocalCache(remoteDataSource.getRandomNumberTrivia);
    });
  }

  Future<Either<Failure, NumberTrivia>> _handleException(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      return catchServerException(getConcreteOrRandom);
    }
    return catchCacheException(_getLastNumberTriviaInCache);
  }

  Future<Either<Failure, NumberTrivia>> saveToLocalCache(
    getConcreteOrRandom,
  ) async {
    final remoteTrivia = await getConcreteOrRandom();
    localDataSource.cacheNumberTrivia(remoteTrivia);
    return Right(remoteTrivia);
  }

  Future<Either<Failure, NumberTrivia>> _getLastNumberTriviaInCache() async {
    final localTrivia = await localDataSource.getLastNumberTrivia();
    return Right(localTrivia);
  }
}
