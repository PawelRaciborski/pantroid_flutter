abstract class FutureUseCase<T> {
  Future<T> execute();
}

class UninitializedUseCaseException implements Exception {
  final String message;

  UninitializedUseCaseException(this.message);
}
