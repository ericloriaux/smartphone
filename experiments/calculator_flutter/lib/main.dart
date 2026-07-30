import 'package:flutter/material.dart';

import 'calculator_engine.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculatrice d'Eric Loriaux",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorEngine _engine = CalculatorEngine();

  static const List<List<String>> _keys = [
    ['C', '⌫', '±', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['0', ',', '='],
  ];

  void _press(String key) {
    setState(() {
      _engine.press(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text("Calculatrice d'Eric Loriaux"),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: _DisplayPanel(
                  operationLabel: _engine.operationLabel,
                  display: _engine.display,
                ),
              ),
              const SizedBox(height: 16),
              _Keypad(rows: _keys, onPressed: _press),
            ],
          ),
        ),
      ),
    );
  }
}

class _DisplayPanel extends StatelessWidget {
  const _DisplayPanel({required this.operationLabel, required this.display});

  final String operationLabel;
  final String display;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (operationLabel.isNotEmpty) ...[
            Text(
              operationLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Semantics(
            label: 'Affichage $display',
            child: ExcludeSemantics(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  key: const ValueKey('calculator_display'),
                  display,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({required this.rows, required this.onPressed});

  final List<List<String>> rows;
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in rows) ...[
          Row(
            children: [
              for (final key in row)
                Expanded(
                  flex: key == '0' ? 2 : 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: _CalculatorButton(
                      label: key,
                      onPressed: () => onPressed(key),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _CalculatorButton extends StatelessWidget {
  const _CalculatorButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  bool get _isOperator => const ['+', '-', '×', '÷', '='].contains(label);

  bool get _isUtility => const ['C', '⌫', '±'].contains(label);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = switch ((label, _isOperator, _isUtility)) {
      ('=', _, _) => colorScheme.primary,
      (_, true, _) => colorScheme.primaryContainer,
      (_, _, true) => colorScheme.secondaryContainer,
      _ => colorScheme.surfaceContainerHigh,
    };
    final foregroundColor = label == '='
        ? colorScheme.onPrimary
        : colorScheme.onSurface;

    return Semantics(
      button: true,
      label: 'Touche $label',
      child: SizedBox(
        height: 64,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
