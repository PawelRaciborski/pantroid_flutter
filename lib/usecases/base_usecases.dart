abstract class FutureUseCase<T> {
  Future<T> execute();
}

abstract class StreamUseCase<T> {
  Stream<T> execute();
}

class UninitializedUseCaseException implements Exception {
  final String message;

  UninitializedUseCaseException(this.message);
}
