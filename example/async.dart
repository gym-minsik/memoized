import 'package:memoized/memoized.dart';
import './timer.dart';

class AsyncExample {
  static final twoSeconds = Future.delayed(Duration(seconds: 2));

  late final fetchDocument = Memoized1((String url) async {
    await twoSeconds;
    return 'response: $url';
  });
}

void main() async {
  final example = AsyncExample();
  await timeAsync(example.fetchDocument('http://www.example.com'));
  await timeAsync(example.fetchDocument('http://www.example.com')); // cached data

  example.fetchDocument.expireAll();
  await timeAsync(example.fetchDocument('http://www.example.com'));
}
