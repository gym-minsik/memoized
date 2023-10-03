import 'package:quiver/collection.dart';

/// Represents a memoization wrapper for a computation that takes one argument
/// and returns a value of type [V].
///
/// This class uses an LRU (Least Recently Used) cache to store results of the
/// computations based on the arguments passed. The cache has a default capacity(128)
/// but can be configured via the constructor.
///
/// This is particularly useful for functions where the computation is expensive
/// and you don't want to recompute the value for the same argument multiple times.
class Memoized1<V, A1> {
  final LruMap<A1, V> _cache;
  final V Function(A1) _body;

  Memoized1(
    V Function(A1) body, {
    int capacity = 128,
  })  : _body = body,
        _cache = LruMap(maximumSize: 128);

  /// Calls the wrapped computation with [arg] and returns the cached value.
  ///
  /// If a cached value for the given [arg] exists, it will return that.
  /// Otherwise, it will compute the value, cache it, and then return it.
  V call(A1 arg) => _cache[arg] ??= _body(arg);

  /// Removes the cached value associated with the given [arg].
  void expire(A1 arg) => _cache.remove(arg);

  /// Clears the entire cache, removing all cached values.
  void expireAll() => _cache.clear();
}
