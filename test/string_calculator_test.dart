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

  test('Should treat newlines as delimiters '
      'When they appear between numbers', () {
    final calc = StringCalculator();
    expect(calc.add("1\n2,3"), 6);
  });

  test('supports custom single-character delimiter', () {
    final calc = StringCalculator();
    expect(calc.add("//;\n1;2"), 3);
  });

  test('Should throw an exception '
      'When a negative number is passed', () {
    final calc = StringCalculator();
    expect(
      () => calc.add("1,-2,3"),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains("negatives not allowed: -2"),
        ),
      ),
    );
  });

  test('Should throw an exception listing all negative numbers '
      'When multiple negative numbers are passed', () {
    final calc = StringCalculator();
    expect(
      () => calc.add("1,-2,3,-4"),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains("negatives not allowed: -2, -4"),
        ),
      ),
    );
  });

  test('Should return the number of calls to add() '
      'When GetCalledCount is invoked', () {
    final calc = StringCalculator();
    expect(calc.getCalledCount(), 0);
    calc.add("1,2");
    expect(calc.getCalledCount(), 1);
    calc.add("3");
    expect(calc.getCalledCount(), 2);
  });
}
