Duration getElaspedTime(void Function() fn) {
  final w = Stopwatch()..start();
  fn();
  w.stop();
  return w.elapsed;
}
