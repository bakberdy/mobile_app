import '../utils/typedef.dart';

abstract class UseCase<T, Params> {
  FutureEither<T> call(Params params);
}

abstract class StreamUseCase<T, Params> {
  StreamEither<T> connect(Params params);
  Future<void> disconnect();
}

class NoParams {
  const NoParams();
}
