import 'package:memoized/memoized.dart';
import 'package:test/test.dart';

import 'get_elaped_time.dart';

int sum() {
  return List.generate(30000000, (index) => index)
      .reduce((value, element) => value + element);
}

void main() {
  group('Memoized', () {
    test('should return the cached value.', () {
      final memoized = sum.memo;
      expect(memoized.isNotComputedYet, true);
      memoized();
      expect(memoized.isComputed, true);

      expect(
          getElaspedTime(memoized), lessThan(const Duration(milliseconds: 7)));
    });

    test('should expire the cached value.', () {
      final memoized = sum.memo;
      expect(memoized.isNotComputedYet, true);
      memoized();
      expect(memoized.isComputed, true);

      memoized.expire();

      expect(memoized.isExpired, true);
      expect(getElaspedTime(memoized),
          greaterThan(const Duration(milliseconds: 7)));
    });

    test('should be expired manually.', () {
      final memoized = sum.memo;
      expect(memoized.isNotComputedYet, true);
      memoized();
      expect(memoized.isComputed, true);

      expect(getElaspedTime(() => memoized(shouldUpdate: true)),
          greaterThan(const Duration(milliseconds: 7)));
    });

    test('should work with nullable types.', () {
      final memoizedNull = Memoized<String?>(() {
        return null;
      });
      final memoizedString = Memoized<String?>(() {
        return '';
      });

      expect(memoizedNull(), null);
      expect(memoizedNull(), null);
      expect(memoizedString(), '');
      expect(memoizedString(), '');
    });
  });
}
