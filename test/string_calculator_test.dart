import 'package:flutter_test/flutter_test.dart';
import 'package:kata_calculator/string_calculator.dart';

void main() {
  test('Should return 0 '
      'When input is empty', () {
    final sc = StringCalculator();
    expect(sc.add(''), 0);
  });
}
