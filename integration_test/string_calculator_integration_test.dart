import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kata_calculator/features/string_calculator/presentation/string_calculator_keys.dart';
import 'package:kata_calculator/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Calculator adds simple comma-separated numbers', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Enter input
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.textField));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton(',')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Keys.keyboardButton('2')));
    await tester.pumpAndSettle();

    // Tap calculate button
    final button = find.byKey(Keys.calculateButton);
    await tester.tap(button);
    await tester.pumpAndSettle();

    // Verify result
    expect(find.text('Result: 3'), findsOneWidget);
  });
}
