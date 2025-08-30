import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kata_calculator/features/string_calculator/presentation/string_calculator_keys.dart';
import 'package:kata_calculator/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {});

  tearDown(() async {});

  testWidgets('Calculator adds simple comma-separated numbers', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.textField));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton(',')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('2')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Result: 3'), findsOneWidget);
  });

  testWidgets('Calculator should return 0 when text is empty', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.keyboardButton('clear')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Result: 0'), findsOneWidget);
  });

  testWidgets('Calculator returns the value, when a single number is added', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.textField));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('1')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Result: 1'), findsOneWidget);
  });

  testWidgets(
    'Calculator should treat newlines as delimiters when they appear between numbers',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final inputField = find.byKey(Keys.textField);
      await tester.enterText(inputField, '1\n2');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.calculateButton));
      await tester.pumpAndSettle();

      expect(find.text('Result: 3'), findsOneWidget);
    },
  );

  testWidgets('Calculator should support custom single-character delimiters', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final demiliterInputField = find.byKey(Keys.demiliterTextField);
    await tester.enterText(demiliterInputField, ';');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.textField));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton(';')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('2')));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Result: 5'), findsOneWidget);
  });

  testWidgets('Calculator should support custom multi-character delimiters', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final demiliterInputField = find.byKey(Keys.demiliterTextField);
    await tester.enterText(demiliterInputField, '***');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.textField));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('***')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('6')));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Result: 9'), findsOneWidget);
  });

  testWidgets('Calculator should show error when negative is added', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final inputField = find.byKey(Keys.textField);
    await tester.enterText(inputField, '-8');

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Exception: negatives not allowed: -8'), findsOneWidget);
  });

  testWidgets(
    'Calculator should listing all negative numbers, when negative is added',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final inputField = find.byKey(Keys.textField);
      await tester.enterText(inputField, '-8,-9,5');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Keys.calculateButton));
      await tester.pumpAndSettle();

      expect(
        find.text('Exception: negatives not allowed: -8, -9'),
        findsOneWidget,
      );
    },
  );

  testWidgets('Calculator should ignore numbers greater than 1000', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final inputField = find.byKey(Keys.textField);
    await tester.enterText(inputField, '1002,5');

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Result: 5'), findsOneWidget);
  });

  testWidgets('Calculator should support multiple delimiters', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final demiliterInputField = find.byKey(Keys.demiliterTextField);
    await tester.enterText(demiliterInputField, '*,;');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.textField));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('3')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('*')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('6')));
    await tester.tap(find.byKey(Keys.keyboardButton(';')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('1')));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Keys.calculateButton));
    await tester.pumpAndSettle();

    expect(find.text('Result: 10'), findsOneWidget);
  });
}
