import 'package:tuple/tuple.dart';

import 'package:quiver/collection.dart';

class Memoized3<V, A1, A2, A3> {
  final LruMap<Tuple3<A1, A2, A3>, V> _cache;
  final V Function(A1, A2, A3) _body;

  Memoized3(V Function(A1, A2, A3) body, {int capacity = 128})
      : _body = body,
        _cache = LruMap(maximumSize: capacity);

  V call(A1 a1, A2 a2, A3 a3) {
    final tuple = Tuple3(a1, a2, a3);
    final cachedValue = _cache[tuple];
    return cachedValue ?? (_cache[tuple] = _body(a1, a2, a3));
  }

  void expire(A1 a1, A2 a2, A3 a3) => _cache.remove(Tuple3(a1, a2, a3));

  void expireAll() => _cache.clear();
}
