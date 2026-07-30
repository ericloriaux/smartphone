import 'package:calculator_flutter/calculator_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculatorEngine', () {
    test('starts at zero', () {
      final engine = CalculatorEngine();

      expect(engine.display, '0');
      expect(engine.operationLabel, isEmpty);
    });

    test('adds decimal numbers with comma display', () {
      final engine = CalculatorEngine();

      for (final key in ['1', ',', '5', '+', '2', ',', '2', '=']) {
        engine.press(key);
      }

      expect(engine.display, '3,7');
    });

    test('chains operations from left to right', () {
      final engine = CalculatorEngine();

      for (final key in ['2', '+', '3', '×', '4', '=']) {
        engine.press(key);
      }

      expect(engine.display, '20');
    });

    test('shows a clear error for division by zero', () {
      final engine = CalculatorEngine();

      for (final key in ['8', '÷', '0', '=']) {
        engine.press(key);
      }

      expect(engine.display, 'Division par zéro');

      engine.press('C');

      expect(engine.display, '0');
    });

    test('supports sign toggle and backspace', () {
      final engine = CalculatorEngine();

      for (final key in ['4', '2', '±', '⌫']) {
        engine.press(key);
      }

      expect(engine.display, '-4');
    });
  });
}
