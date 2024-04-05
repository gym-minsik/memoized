[**English**](README.md)

## Memoized

간단하지만 매우 강력한 캐싱 라이브러리입니다. 함수의 결괏값을 저장해놓은 뒤, 해당 함수가 같은 인자로 다시 호출되면 이전에 저장해놓은 결괏값을 즉시 리턴합니다. 

## 사용 방법

**메모이제이션**: 함수를 Wrapping하여 결괏값을 캐싱하세요.
  ``` dart
  import 'package:memoized/memoized.dart'; 

  final sum = (() => 1.to(999999999).sum()).memo;
  print(sum());  // Computes the sum
  print(sum());  // Returns the cached sum
  ```

**LRU Cache**: 인자를 받는 함수의 경우 LRU(Least Recently Used) 캐시가 내부적으로 사용됩니다. 파라미터를 Key로 하여 가장 최근의 결괏값을 캐싱해놓습니다.

```dart
import 'package:memoized/memoized.dart';

// Memoized1<ReturnType, ArgumentType>
late final Memoized1<int, int> fib;

fib = Memoized1((int n) {
  if (n <= 1) return n;
  return fib(n-1) + fib(n-2);
}, capacity: 128);

print(fib(80));
```

**Expiry**: 수동으로 캐시를 만료시킬 수 있습니다.
```dart
Iterable<int> numbers = 1.to(30000000);
final calculateSum = (() => numbers.sum()).memo;
print(calculateSum());

numbers = 1.to(9043483);
calculateSum.expire();     // Cache is cleared but not computed

final value = calculateSum();  // Recomputed here
```

**Within a Class**: 클래스에서의 사용 사례입니다.
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

## Memoized 라이프타임과 관련한 중요 공지

### 함수 내 변수로 `Memoized`를 생성하는 것을 피하세요.
아래 코드 예제는 Memoized 사용시 빠질 수 있는 함정을 보여줍니다.

```dart
class _VeryCoolWidgetState extends State<VeryCoolWidget> {
  @override
  Widget build(BuildContext context) {
    final size = Memoized(expensiveCalculation);

    return CoolWidget(size: size());
  }
}
```

해당 예제에서는 매 `build` 호출마다 Memoized가 재생성되어 캐시또한 매번 재생성되어 원하는 캐시값을 가져올 수 없습니다.

### 해결책
해당 함정을 피하기 위해서는 다음과 같은 접근 방법을 고려해보세요.

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
이 예제의 경우 Memoized의 라이프타임이 해당 인스턴스의 라이프타임과 같아지므로 매 build호출시 원하는 캐시값을 가져올 수 있습니다.
