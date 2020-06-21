import 'package:dartz/dartz.dart';

import 'failures.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

typedef Future<Either<Failure, T>> _function<T>();

Future<Either<Failure, T>> catchServerException<T>(
    _function<T> functionBody) async {
  try {
    return await functionBody();
  } on ServerException {
    return Left(ServerFailure());
  }
}

Future<Either<Failure, T>> catchCacheException<T>(
    _function<T> functionBody) async {
  try {
    return await functionBody();
  } on CacheException {
    return Left(CacheFailure());
  }
}
