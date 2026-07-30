enum CalculatorOperator {
  add('+'),
  subtract('-'),
  multiply('×'),
  divide('÷');

  const CalculatorOperator(this.symbol);

  final String symbol;
}

class CalculatorEngine {
  static const String decimalSeparator = ',';

  String _display = '0';
  double? _leftOperand;
  CalculatorOperator? _pendingOperator;
  bool _startNewEntry = false;
  bool _justEvaluated = false;
  String? _errorMessage;

  String get display => _errorMessage ?? _display;

  String get operationLabel {
    final leftOperand = _leftOperand;
    final pendingOperator = _pendingOperator;
    if (leftOperand == null ||
        pendingOperator == null ||
        _errorMessage != null) {
      return '';
    }

    return '${_format(leftOperand)} ${pendingOperator.symbol}';
  }

  void press(String key) {
    switch (key) {
      case 'C':
        clear();
      case '⌫':
        _backspace();
      case '±':
        _toggleSign();
      case ',':
        _inputDecimalSeparator();
      case '=':
        _evaluate();
      case '+':
        _chooseOperator(CalculatorOperator.add);
      case '-':
        _chooseOperator(CalculatorOperator.subtract);
      case '×':
        _chooseOperator(CalculatorOperator.multiply);
      case '÷':
        _chooseOperator(CalculatorOperator.divide);
      default:
        if (_isDigit(key)) {
          _inputDigit(key);
        }
    }
  }

  void clear() {
    _display = '0';
    _leftOperand = null;
    _pendingOperator = null;
    _startNewEntry = false;
    _justEvaluated = false;
    _errorMessage = null;
  }

  void _inputDigit(String digit) {
    _clearErrorForNewInput();

    if (_justEvaluated && _pendingOperator == null) {
      _display = '0';
      _justEvaluated = false;
    }

    if (_startNewEntry) {
      _display = digit;
      _startNewEntry = false;
      return;
    }

    if (_display == '0') {
      _display = digit;
      return;
    }

    if (_display == '-0') {
      _display = '-$digit';
      return;
    }

    if (_significantInputLength < 12) {
      _display += digit;
    }
  }

  void _inputDecimalSeparator() {
    _clearErrorForNewInput();

    if (_justEvaluated && _pendingOperator == null) {
      _display = '0';
      _justEvaluated = false;
    }

    if (_startNewEntry) {
      _display = '0$decimalSeparator';
      _startNewEntry = false;
      return;
    }

    if (!_display.contains(decimalSeparator)) {
      _display += decimalSeparator;
    }
  }

  void _toggleSign() {
    if (_errorMessage != null || _display == '0') {
      return;
    }

    if (_display.startsWith('-')) {
      _display = _display.substring(1);
    } else {
      _display = '-$_display';
    }
  }

  void _backspace() {
    if (_errorMessage != null) {
      clear();
      return;
    }

    if (_startNewEntry || _display.length == 1) {
      _display = '0';
      _startNewEntry = false;
      return;
    }

    if (_display.length == 2 && _display.startsWith('-')) {
      _display = '0';
      return;
    }

    _display = _display.substring(0, _display.length - 1);
  }

  void _chooseOperator(CalculatorOperator operator) {
    if (_errorMessage != null) {
      return;
    }

    final currentValue = _currentValue;
    if (_leftOperand != null && _pendingOperator != null && !_startNewEntry) {
      final result = _calculate(_leftOperand!, currentValue, _pendingOperator!);
      if (result == null) {
        return;
      }
      _leftOperand = result;
      _display = _format(result);
    } else {
      _leftOperand = currentValue;
    }

    _pendingOperator = operator;
    _startNewEntry = true;
    _justEvaluated = false;
  }

  void _evaluate() {
    if (_errorMessage != null ||
        _leftOperand == null ||
        _pendingOperator == null) {
      return;
    }

    final result = _calculate(_leftOperand!, _currentValue, _pendingOperator!);
    if (result == null) {
      return;
    }

    _display = _format(result);
    _leftOperand = null;
    _pendingOperator = null;
    _startNewEntry = true;
    _justEvaluated = true;
  }

  double? _calculate(
    double leftOperand,
    double rightOperand,
    CalculatorOperator operator,
  ) {
    switch (operator) {
      case CalculatorOperator.add:
        return leftOperand + rightOperand;
      case CalculatorOperator.subtract:
        return leftOperand - rightOperand;
      case CalculatorOperator.multiply:
        return leftOperand * rightOperand;
      case CalculatorOperator.divide:
        if (rightOperand == 0) {
          _showError('Division par zéro');
          return null;
        }
        return leftOperand / rightOperand;
    }
  }

  double get _currentValue =>
      double.parse(_display.replaceAll(decimalSeparator, '.'));

  int get _significantInputLength =>
      _display.replaceAll('-', '').replaceAll(decimalSeparator, '').length;

  bool _isDigit(String key) => key.length == 1 && '0123456789'.contains(key);

  void _clearErrorForNewInput() {
    if (_errorMessage != null) {
      clear();
    }
  }

  void _showError(String message) {
    _errorMessage = message;
    _leftOperand = null;
    _pendingOperator = null;
    _startNewEntry = true;
    _justEvaluated = false;
  }

  String _format(double value) {
    if (value == 0) {
      return '0';
    }

    final wholeNumber = value.truncateToDouble();
    if (value == wholeNumber) {
      return wholeNumber.toInt().toString();
    }

    var text = value.toStringAsPrecision(12);
    if (text.contains('e')) {
      return text.replaceAll('.', decimalSeparator);
    }

    while (text.contains('.') && text.endsWith('0')) {
      text = text.substring(0, text.length - 1);
    }

    if (text.endsWith('.')) {
      text = text.substring(0, text.length - 1);
    }

    return text.replaceAll('.', decimalSeparator);
  }
}
