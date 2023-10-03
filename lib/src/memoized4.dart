import 'package:quiver/collection.dart';

/// Represents a memoization wrapper for a computation that takes four arguments
/// and returns a value of type [V].
///
/// This class uses an LRU (Least Recently Used) cache to store results of the
/// computations based on the arguments passed. The cache has a default capacity(128)
/// but can be configured via the constructor.
///
/// This is particularly useful for functions where the computation is expensive
/// and you don't want to recompute the value for the same argument multiple times.
class Memoized4<V, A1, A2, A3, A4> {
  final LruMap<(A1, A2, A3, A4), V> _cache;
  final V Function(A1, A2, A3, A4) _body;

  Memoized4(V Function(A1, A2, A3, A4) body, {int capacity = 128})
      : _body = body,
        _cache = LruMap(maximumSize: capacity);

  /// Calls the wrapped computation with the provided arguments [a1], [a2], [a3] and [a4].
  ///
  /// If a cached value for the given pair of arguments ([a1], [a2], [a3], [a4]) exists, it
  /// will return that value. Otherwise, it computes the value using the provided
  /// computation, caches the result for subsequent calls with the same arguments,
  /// and then returns the computed value.
  ///
  /// The cache uses the pair ([a1], [a2], [a3], [a4]) as the key to retrieve stored results.
  V call(A1 a1, A2 a2, A3 a3, A4 a4) {
    final tuple = (a1, a2, a3, a4);
    final cachedValue = _cache[tuple];
    return cachedValue ?? (_cache[tuple] = _body(a1, a2, a3, a4));
  }

  /// Removes the cached value associated with the given arguments.
  void expire(A1 a1, A2 a2, A3 a3, A4 a4) => _cache.remove((a1, a2, a3, a4));

  /// Clears the entire cache, removing all cached values.

  void expireAll() => _cache.clear();
}
