import 'package:tuple/tuple.dart';
import 'package:quiver/collection.dart';

class Memoized2<V, A1, A2> {
  final LruMap<Tuple2<A1, A2>, V> _cache;
  final V Function(A1, A2) _body;

  Memoized2(V Function(A1, A2) body, {int capacity = 128})
      : _body = body,
        _cache = LruMap(maximumSize: capacity);

  V call(A1 a1, A2 a2) {
    final tuple = Tuple2(a1, a2);
    final cachedValue = _cache[tuple];
    return cachedValue ?? (_cache[tuple] = _body(a1, a2));
  }

  void expire(A1 a1, A2 a2) => _cache.remove(Tuple2(a1, a2));

  void expireAll() => _cache.clear();
}
