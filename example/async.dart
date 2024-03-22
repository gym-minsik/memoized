import 'package:memoized/memoized.dart';
import './timer.dart';

class AsyncExample {
  late final fetchDocument = Memoized1((String url) async {
    await Future.delayed(Duration(seconds: 2));

    return 'response: $url';
  });
}

void main() async {
  final example = AsyncExample();
  await timeAsync(example.fetchDocument('http://www.example.com'));

  // It returns the value immediately.
  await timeAsync(example.fetchDocument('http://www.example.com'));

  example.fetchDocument.expireAll();

  // The cache has been cleared. It returns the value after a 2-second delay.
  await timeAsync(example.fetchDocument('http://www.example.com'));
}
