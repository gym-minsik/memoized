Future<void> timeAsync<V>(Future<V> future) async {
  final w = Stopwatch()..start();
  final result = await future;
  w.stop();
  final elapsed = '${w.elapsed.inMilliseconds}ms'.padLeft(6);
  print('[$elapsed] $result returned');
}

void time<V>(V Function() fn) {
  final w = Stopwatch()..start();
  final result = fn();
  w.stop();
  final elapsed = '${w.elapsed.inMilliseconds}ms'.padLeft(6);
  print('[$elapsed] $result returned');
}
