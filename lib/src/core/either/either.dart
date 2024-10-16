/// Signature of callbacks that have no arguments and return right or left value.
typedef Callback<T> = void Function(T value);

/// Represents a value of one of two possible types (a disjoint union).
/// Instances of [Either] are either an instance of [Left] or [Right].
/// FP Convention dictates that:
///   [Left] is used for failure cases
///   [Right] is used for success cases
abstract class Either<L, R> {
  Either() {
    if (!isLeft && !isRight) {
      throw Exception('The Either should be either Left or Right.');
    }
  }

  /// Represents the left side of [Either] class which by convention is a failure.
  bool get isLeft => this is Left<L, R>;

  /// Represents the right side of [Either] class which by convention is a success.
  bool get isRight => this is Right<L, R>;

  L get left {
    if (this is Left<L, R>) {
      return (this as Left<L, R>).value;
    } else {
      throw Exception('Illegal use. You should check isLeft() before calling left.');
    }
  }

  R get right {
    if (this is Right<L, R>) {
      return (this as Right<L, R>).value;
    } else {
      throw Exception('Illegal use. You should check isRight() before calling right.');
    }
  }

  void either(Callback<L> fnL, Callback<R> fnR) {
    if (isLeft) {
      final left = this as Left<L, R>;
      fnL(left.value);
    }
    if (isRight) {
      final right = this as Right<L, R>;
      fnR(right.value);
    }
  }
}

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;
  Right(this.value);
}