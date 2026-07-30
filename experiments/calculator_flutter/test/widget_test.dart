import 'package:calculator_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('calculates a simple addition', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.widgetWithText(FilledButton, '2'));
    await tester.tap(find.widgetWithText(FilledButton, '+'));
    await tester.tap(find.widgetWithText(FilledButton, '3'));
    await tester.tap(find.widgetWithText(FilledButton, '='));
    await tester.pump();

    expect(_displayText(tester), '5');
  });

  testWidgets('clears the display', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.widgetWithText(FilledButton, '9'));
    await tester.tap(find.widgetWithText(FilledButton, 'C'));
    await tester.pump();

    expect(_displayText(tester), '0');
  });
}

String _displayText(WidgetTester tester) {
  final display = tester.widget<Text>(
    find.byKey(const ValueKey('calculator_display')),
  );

  return display.data ?? '';
}
