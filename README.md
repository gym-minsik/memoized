[**한국어**](README_kr.md)

## Memoized

The memoized package is designed to store the previously computed value of a function so that if the function is called again with the same parameters, the stored value is returned immediately instead of recalculating it.

## Features
**Memoization**: Wraps a function and caches its result.

  ``` dart
  import 'package:memoized/memoized.dart'; 

  final sum = (() => 1.to(999999999).sum()).memo;
  print(sum());  // Computes the sum
  print(sum());  // Returns the cached sum
  ```

**LRU Cache**: For functions that accept parameters, an LRU (Least Recently Used) cache is maintained. It caches the results of the most recent function calls based on their parameters.

```dart
import 'package:memoized/memoized.dart';

// Memoized1<ReturnType, ArgumentType>
late final Memoized1<int, int> fib;
fib = Memoized1((int n) {
  if (n <= 1) return n;
  return fib(n-1) + fib(n-2);
});
print(fib(80));
```

**Expiry**: Allows you to manually expire the cached value.

  ```dart
  Iterable<int> numbers = 1.to(30000000);
  final calculateSum = (() => numbers.sum()).memo;
  
  numbers = 1.to(9043483);
  calculateSum.expire();     // Cache is cleared but not computed

  final value = calculateSum();  // Recomputed here
  ```

**Within a Class**: You can use memoized functions within classes too.

  ```dart
  class IntervalTimer {
    final List<Duration> timers = [];
    late final totalDuration = _totalDurationImpl.memo;

    Duration _totalDurationImpl() => timers.fold<Duration>(
      Duration.zero,
      (p, v) => p + v
    );
  }

  ```

## Important Notes on the Lifetime of Memoized Instances
### Beware of creating `Memoized` instances as function variables.
The following code snippet demonstrates a pitfall to avoid when using Memoized:

```dart
class _VeryCoolWidgetState extends State<VeryCoolWidget> {
  @override
  Widget build(BuildContext context) {
    final size = Memoized(expensiveCalculation);

    return CoolWidget(size: size());
  }
}
```
In this pattern, a new `Memoized` instance is created and destroyed with every `build` invocation. This means that the previously calculated result will not be cached, defeating the purpose of Memoization.

### Solution: Use a memoized instance outside the function
To avoid this issue, consider the following approach:

```dart
class _VeryCoolWidgetState extends State<VeryCoolWidget> {
  late final expensiveCalculation = _expensiveCalculationImpl.memo;

  Size _expensiveCalculationImpl() {...}

  @override
  Widget build(BuildContext context) {
    final size = expensiveCalculation();
    
    return CoolWidget(size: size);
  }
}
```
Here, the `Memoized` instance is created once outside the `build` function and assigned to a `late final` variable. This ensures that the instance persists across `build` calls, allowing for proper result caching.