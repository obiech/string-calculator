import 'package:flutter_test/flutter_test.dart';
import 'package:kata_calculator/string_calculator.dart';

void main() {
  late StringCalculator calc;

  setUp(() {
    calc = StringCalculator();
  });

  group('StringCalculator.add() ', () {
    test('Should return 0 '
        'When input is empty', () {
      expect(calc.add(''), 0);
    });

    test('Should return the number '
        'When a single number is given', () {
      expect(calc.add('7'), 7);
    });

    test('Should return the sum '
        'When input contains two numbers separated by a comma', () {
      expect(calc.add("1,2"), 3);
    });

    test('Should return the sum '
        'When input has multiple numbers separated by commas', () {
      expect(calc.add("1,2,3,4"), 10);
    });

    test('Should treat newlines as delimiters '
        'When they appear between numbers', () {
      expect(calc.add("1\n2,3"), 6);
    });

    test('Should support custom single-character delimiters '
        'When specified at the beginning of the input', () {
      expect(calc.add("//;\n1;2"), 3);
    });

    test('Should throw an exception '
        'When a negative number is passed', () {
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

    test('Should ignore numbers greater than 1000 '
        'when summing the input values', () {
      expect(calc.add("2,1001"), equals(2));
    });

    test('Should support delimiters of any length '
        'When custom delimiters are specified', () {
      expect(calc.add("//[***]\n1***2***3"), equals(6));
    });

    test('Should support multiple delimiters '
        'When custom delimiters are specified', () {
      expect(calc.add('//[*][%]\n1*2%3'), 6);
    });

    test(
      'Should support multiple custom delimiters of any length '
      'When the input defines delimiters in the //[delim1][delim2]... format '
      'Then the calculator should correctly split numbers using all of them',
      () {
        expect(calc.add("//[**][%%]\n1**2%%3"), equals(6));
      },
    );
  });

  group('StringCalculator.getCalledCount() ', () {
    test('Should return the number of calls to add() '
        'When GetCalledCount is invoked', () {
      expect(calc.getCalledCount(), 0);
      calc.add("1,2");
      expect(calc.getCalledCount(), 1);
      calc.add("3");
      expect(calc.getCalledCount(), 2);
    });
  });
}
