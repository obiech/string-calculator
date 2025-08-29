import 'package:flutter_test/flutter_test.dart';
import 'package:kata_calculator/string_calculator.dart';

void main() {
  test('Should return 0 '
      'When input is empty', () {
    final sc = StringCalculator();
    expect(sc.add(''), 0);
  });

  test('Should return the number '
      'When a single number is given', () {
    final sc = StringCalculator();
    expect(sc.add('7'), 7);
  });

  test('Should return the sum '
      'When input contains two numbers separated by a comma', () {
    final calc = StringCalculator();
    expect(calc.add("1,2"), 3);
  });

  test('returns sum when input has multiple numbers separated by comma', () {
    final calc = StringCalculator();
    expect(calc.add("1,2,3,4"), 10);
  });
}
