import 'package:memoized/memoized.dart';
import 'package:test/test.dart';

Duration time(void Function() fn) {
  final w = Stopwatch()..start();
  fn();
  w.stop();
  return w.elapsed;
}

void main() {
  const ms100 = Duration(milliseconds: 100);
  const ms10 = Duration(milliseconds: 10);

  group('Memoized1', () {
    test('Fibonacci Series using Recursion', () {
      late final Memoized1<int, int> fib;
      fib = Memoized1((n) {
        return n <= 1 ? n : fib(n - 1) + fib(n - 2);
      });

      expect(time(() => fib(60)) < ms10, true);
    });
  });

  group('Memoized2', () {
    test('a simple integer summation', () {
      late final rangeSum = Memoized2<int, int, int>((begin, end) {
        int sum = 0;
        for (int i = begin; i < end; i++) {
          sum += i;
        }
        return sum;
      });

      time(() => rangeSum(0, 982323300));
      expect(time(() => rangeSum(0, 982323300)) < ms10, true);
    });

    test('expire', () {
      late final rangeSum = Memoized2<int, int, int>((begin, end) {
        int sum = 0;
        for (int i = begin; i < end; i++) {
          sum += i;
        }
        return sum;
      });
      const begin = 0;
      const end = 982323300;
      time(() => rangeSum(begin, end));
      rangeSum.expire(begin, end);
      expect(time(() => rangeSum(begin, end)) > ms100, true);
    });
  });
}
