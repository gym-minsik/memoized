import 'package:memoized/memoized.dart';
import './timer.dart';

class MemoizedExample {
  late final sumRange = Memoized2((int begin, int end) {
    int sum = 0;
    for (int i = begin; i <= end; i++) {
      sum += i;
    }
    return sum;
  });

  static final one = BigInt.one;
  static final two = BigInt.two;
  late final Memoized1<BigInt, BigInt> fibonacci = Memoized1((n) {
    if (n <= one) return n;
    return fibonacci(n - one) + fibonacci(n - two);
  });
}

void main() {
  final example = MemoizedExample();
  time(() => example.sumRange(0, 999999999));
  time(() => example.sumRange(0, 999999999)); // cached data

  // recursion by using cached data (top-down dynamic programming)
  time(() => example.fibonacci(BigInt.parse('300')));
}
