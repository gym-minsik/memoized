import 'package:tuple/tuple.dart';

import 'package:quiver/collection.dart';

class Memoized4<V, A1, A2, A3, A4> {
  final LruMap<Tuple4<A1, A2, A3, A4>, V> _cache;
  final V Function(A1, A2, A3, A4) _body;

  Memoized4(V Function(A1, A2, A3, A4) body, {int capacity = 128})
      : _body = body,
        _cache = LruMap(maximumSize: capacity);

  V call(A1 a1, A2 a2, A3 a3, A4 a4) {
    final tuple = Tuple4(a1, a2, a3, a4);
    final cachedValue = _cache[tuple];
    return cachedValue ?? (_cache[tuple] = _body(a1, a2, a3, a4));
  }

  void expire(A1 a1, A2 a2, A3 a3, A4 a4) =>
      _cache.remove(Tuple4(a1, a2, a3, a4));

  void expireAll() => _cache.clear();
}
