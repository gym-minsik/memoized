enum MemoizedStatus { notComputed, computed, expired }

/// Represents a memoization wrapper for a computation that returns a value of type [V].
///
/// This class is used to cache and manage the result of a computation so it doesn't
/// need to be recomputed unless explicitly told to or if it's marked as expired.
class Memoized<V> {
  /// The actual computation that this memoization wrapper wraps around.
  final V Function() _computation;

  /// Indicates if the cached value is expired and needs to be recomputed.
  var _status = MemoizedStatus.notComputed;

  /// The cached value after computation.
  late V _memoized;

  Memoized(this._computation);

  /// Check if the memoized value is expired.
  bool get isExpired => _status == MemoizedStatus.expired;

  /// Check if the memoized value is not computed yet.
  bool get isNotComputedYet => _status == MemoizedStatus.notComputed;

  /// Check if the memoized value is successfully computed.
  bool get isComputed => _status == MemoizedStatus.computed;

  /// Calls the wrapped computation and returns the cached value.
  ///
  /// If [shouldUpdate] is set to `true` or the value is marked as expired,
  /// it will recompute the value. Otherwise, it will return the cached value.
  V call({bool shouldUpdate = false}) {
    if (isNotComputedYet || shouldUpdate || isExpired) {
      _memoized = _computation();
      _status = MemoizedStatus.computed;
    }
    return _memoized!;
  }

  /// Marks the cached value as expired, so the next call will trigger a recomputation.
  void expire() => _status = MemoizedStatus.expired;

  @override
  String toString() {
    return '$runtimeType {\n'
        '  functionType: $V Function(),\n'
        '  lastComputation: ${_memoized?.toString()},\n'
        '  status: $_status\n'
        '}';
  }
}

/// Extension methods on functions returning type [V] to enable easy creation of [Memoized] instances.
extension Memo0Ext<V> on V Function() {
  /// Returns a [Memoized] instance wrapping around this function.
  Memoized<V> get memo => Memoized(this);
}
