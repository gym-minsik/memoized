import 'package:to_string_pretty/to_string_pretty.dart';

/// Represents a memoization wrapper for a computation that returns a value of type [V].
///
/// This class is used to cache and manage the result of a computation so it doesn't
/// need to be recomputed unless explicitly told to or if it's marked as expired.
class Memoized<V> {
  /// The actual computation that this memoization wrapper wraps around.
  final V Function() _computation;

  /// Indicates if the cached value is expired and needs to be recomputed.
  bool _expired = true;

  /// The cached value after computation.
  V? _memoized;

  Memoized(this._computation);

  /// Calls the wrapped computation and returns the cached value.
  ///
  /// If [shouldUpdate] is set to `true` or the value is marked as expired,
  /// it will recompute the value. Otherwise, it will return the cached value.
  V call({bool shouldUpdate = false}) {
    if (shouldUpdate || _expired) {
      _memoized = _computation();
      _expired = false;
    }
    return _memoized!;
  }

  /// Marks the cached value as expired, so the next call will trigger a recomputation.
  void expire() => _expired = true;

  @override
  String toString() {
    const notComputedMessage = 'NOT_COMPUTED_YET';
    final last = _memoized?.toString();
    String lastComputation;
    if (last == notComputedMessage) {
      lastComputation = 'NOT_CALCULATED_YET';
    } else {
      lastComputation = notComputedMessage;
    }

    return toStringPretty(this, {
      'functionType': '$V Function()',
      'lastComputation': lastComputation,
      'expired': '$_expired',
    });
  }
}

/// Extension methods on functions returning type [V] to enable easy creation of [Memoized] instances.
extension Memo0Ext<V> on V Function() {
  /// Returns a [Memoized] instance wrapping around this function.
  Memoized<V> get memo => Memoized(this);
}
