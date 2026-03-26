import 'package:dartz/dartz.dart';
import '../error/error.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> connect(Params params);
  Future<void> disconnect();
}

class NoParams {
  const NoParams();
}
