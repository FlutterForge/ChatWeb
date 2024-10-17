import 'package:flutter_test/flutter_test.dart';

void main() {
  test('1-test', () {
    String text = 'J a m o l B r o ';
    expect(text.replaceAll(' ', ''), 'JamolBro');
  });

  test('2-test', () {
    final multiply = nimadir();
    expect(multiply.divider(0,2), 1);
  });
}

class nimadir {
  int divider(int a, int b) => (a / b).toInt();
}
