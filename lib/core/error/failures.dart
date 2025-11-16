abstract class Failure {
  final String message;
  const Failure(this.message);
  @override
  String toString() => message;
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

