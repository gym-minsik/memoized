import 'package:quiver/collection.dart';

class Memoized5<V, A1, A2, A3, A4, A5> {
  final LruMap<(A1, A2, A3, A4, A5), V> _cache;
  final V Function(A1, A2, A3, A4, A5) _body;

  Memoized5(V Function(A1, A2, A3, A4, A5) body, {int capacity = 128})
      : _body = body,
        _cache = LruMap(maximumSize: capacity);

  V call(A1 a1, A2 a2, A3 a3, A4 a4, A5 a5) {
    final tuple = (a1, a2, a3, a4, a5);
    final cachedValue = _cache[tuple];
    return cachedValue ?? (_cache[tuple] = _body(a1, a2, a3, a4, a5));
  }

  void expire(A1 a1, A2 a2, A3 a3, A4 a4, A5 a5) =>
      _cache.remove((a1, a2, a3, a4, a5));

  void expireAll() => _cache.clear();
}
