import 'package:quiver/collection.dart';

class Memoized1<V, A1> {
  final LruMap<A1, V> _cache;
  final V Function(A1) _body;

  Memoized1(
    V Function(A1) body, {
    int capacity = 128,
  })  : _body = body,
        _cache = LruMap(maximumSize: 128);

  V call(A1 arg) => _cache[arg] ??= _body(arg);

  void expire(A1 arg) => _cache.remove(arg);
  void expireAll() => _cache.clear();
}
