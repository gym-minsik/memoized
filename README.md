## Overview

- saves the previously computed value

  ```dart
  final sum = Memoized(() => 1.to(999999999).sum());
  print(sum());
  print(sum()); // returned immediately
  ```

- with LRU Cache (Fibonacci series)

  ```dart
  // Memoized1<ReturnType, ArgumentType>
  late final Memoized1<int, int> fib;
  fib = Memoized1((int n) {
    if (n <= 1) return n;
    return fib(n-1) + fib(n-2);
  });
  
  print(fib(80));
  ```

  Memoized1~5 maintains an LRU cache that uses a function argument as ***key*** and the result value according to the function arguments as ***value***, as follows.

  ```dart
  LruMap<ArgumentType, ReturnType>
  ```

## Installing

```yaml
dependencies:
  memoized:
```

```dart
import 'package:memoized/memoized.dart';
```

## Memoized

Wrap a function to store the previously computed value and return this value on the next call.

- **Basic**

  ```dart
  Iterable<int> numbers = 1.to(30000000);
  final calculateSum = (() => numbers.sum()).memo;
  
  print(time(calculateSum));
  print(time(calculateSum));  // It returns the memoized value.
  ```

- **expire**

  ```dart
  Iterable<int> numbers = 1.to(30000000);
  final calculateSum = (() => numbers.sum()).memo;
  print(calculateSum());
  
  numbers = 1.to(9043483);
  calculateSum.expire()  // not computed
  
  numbers = 1.to(45000000);
  calculateSum.expire()  // not computed
  
  final value = calculateSum()   // recomputed at this point.
  ```

- ### in Class

  ```dart
  class IntervalTimer {
    final List<Duration> timers = [/* durations */];
      
    late final totalDuration = _totalDurationImpl.memo;
    Duration _totalDurationImpl() => timers.fold<Duration>(
      Duration.zero,
    	(p, v) => p + v
    );
  }
  ```

## Memoized1 ~ 5

Decorator to wrap a function with a memoizing callable that saves up to the *capacity* most recent calls.

- **fibonacci**

  ```dart
  // Memoized1<ReturnType, ArgumentType>
  late final Memoized1<int, int> fib;
  fib = Memoized1((int n) {
      if (n <= 1) return n;
      return fib(n - 1) + fib(n - 2);
  });
  
  print(fib(90));
  
  ```

- **expire**

  ```dart
  print(await fetchDoument('hello')); 
  fetchDocument.expire('hello');
  print(await fetchDoument('hello'));
  ```

- **in Class**

  ```dart
  class Test {
    late final Memoized1<int, int> fib = Memoized1(
      (n) => n <= 1 ? n : fib(n - 1) + fib(n - 2),
    );
  }
  ```

- **capacity**

  ```dart
  class Test {
    late final Memoized1<int, int> fib = Memoized1(
      (n) => n <= 1 ? n : fib(n - 1) + fib(n - 2),
      capacity: 10, // default == 128
    );
  }
  ```
  
  



