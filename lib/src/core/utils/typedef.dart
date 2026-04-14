import 'package:dartz/dartz.dart';
import '../error/error.dart';

/// Common type definitions for cleaner code
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef StreamEither<T> = Stream<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
