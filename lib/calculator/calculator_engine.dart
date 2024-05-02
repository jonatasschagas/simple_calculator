import 'dart:math';

enum CalculatorOperationType {
  add('+'),
  substract('-'),
  multiply('x'),
  divide('÷'),
  equals('='),
  sign('±'),
  clear('C'),
  percent('%'),
  number('N'),
  dot('.'),
  openParenthesis('('),
  closeParenthesis(')');

  const CalculatorOperationType(this._keyCharacter);

  final String _keyCharacter;

  String get keyCharacter => _keyCharacter;
}

class CalculatorOperation {
  CalculatorOperationType operation;
  double operand;

  CalculatorOperation(this.operation, this.operand);
}

class CalculatorEngine {
  CalculatorEngine();

  final List<CalculatorOperation> _currentExpression = [];
  bool _clearDisplay = false;
  CalculatorOperationType _lastOperation = CalculatorOperationType.number;

  final List<CalculatorOperationType> _operations = [
    CalculatorOperationType.add,
    CalculatorOperationType.substract,
    CalculatorOperationType.multiply,
    CalculatorOperationType.divide
  ];

  String get display => _currentExpression.isEmpty
      ? ''
      : _formatNumber(_currentExpression.last.operand);
  String get lastOperationKey => _lastOperation.keyCharacter;
  String get currentExpression => _currentExpression
      .map((e) => e.operation == CalculatorOperationType.number
          ? _formatNumber(e.operand)
          : e.operation.keyCharacter)
      .join(" ");

  void Function(String) _onCalculationCompleted = (String result) {};
  set onCalculationCompletedHandler(void Function(String) handler) {
    _onCalculationCompleted = handler;
  }

  double _add(double a, double b) {
    return a + b;
  }

  double _subtract(double a, double b) {
    return a - b;
  }

  double _multiply(double a, double b) {
    return a * b;
  }

  double _divide(double a, double b) {
    return a / b;
  }

  void handleInput(String input) {
    if (_clearDisplay) {
      if (_currentExpression.isNotEmpty) {
        _currentExpression.last.operand = 0;
      }
      _clearDisplay = false;
    }

    CalculatorOperationType operationType = _getOperationType(input);

    if (operationType == CalculatorOperationType.clear) {
      _clear();
      return;
    }

    if (operationType == CalculatorOperationType.number ||
        operationType == CalculatorOperationType.dot) {
      _processNumber(input);
      return;
    }

    if (operationType == CalculatorOperationType.equals) {
      _calculate();
    } else if (operationType == CalculatorOperationType.sign) {
      _changeSign();
    } else if (operationType == CalculatorOperationType.percent) {
      _percent();
    } else if (_operations.contains(operationType)) {
      _processOperation(operationType);
    }
  }

  CalculatorOperationType _getOperationType(String input) {
    if (input == CalculatorOperationType.add.keyCharacter) {
      return CalculatorOperationType.add;
    } else if (input == CalculatorOperationType.substract.keyCharacter) {
      return CalculatorOperationType.substract;
    } else if (input == CalculatorOperationType.multiply.keyCharacter) {
      return CalculatorOperationType.multiply;
    } else if (input == CalculatorOperationType.divide.keyCharacter) {
      return CalculatorOperationType.divide;
    } else if (input == CalculatorOperationType.equals.keyCharacter) {
      return CalculatorOperationType.equals;
    } else if (input == CalculatorOperationType.sign.keyCharacter) {
      return CalculatorOperationType.sign;
    } else if (input == CalculatorOperationType.clear.keyCharacter) {
      return CalculatorOperationType.clear;
    } else if (input == CalculatorOperationType.percent.keyCharacter) {
      return CalculatorOperationType.percent;
    } else {
      return CalculatorOperationType.number;
    }
  }

  void _clear() {
    _lastOperation = CalculatorOperationType.number;
    _currentExpression.clear();
  }

  void _changeSign() {
    if (_currentExpression.isEmpty ||
        _currentExpression.last.operation != CalculatorOperationType.number) {
      return;
    }

    _currentExpression.last.operand *= -1;
  }

  void _percent() {
    if (_currentExpression.isEmpty ||
        _currentExpression.last.operation != CalculatorOperationType.number) {
      return;
    }

    _currentExpression.last.operand /= 100;
  }

  void _processNumber(String input) {
    if (input == CalculatorOperationType.dot.keyCharacter &&
        !_isInteger(_currentExpression.last.operand)) {
      // current number is already a decimal
      return;
    }

    if (_currentExpression.isNotEmpty) {
      // assumes the last element in the expression is number
      var currentNumber = _currentExpression.last.operand;
      _currentExpression.last.operand =
          currentNumber * 10 + double.parse(input);
    } else {
      _currentExpression.add(CalculatorOperation(
          CalculatorOperationType.number, double.parse(input)));
    }
  }

  void _processOperation(CalculatorOperationType operationType) {
    if (_currentExpression.length >= 3 &&
        (operationType == CalculatorOperationType.multiply ||
            operationType == CalculatorOperationType.divide)) {
      // add parentheses to the current expression
      _currentExpression.insert(
          0, CalculatorOperation(CalculatorOperationType.openParenthesis, 0));
      _currentExpression.add(
          CalculatorOperation(CalculatorOperationType.closeParenthesis, 0));
    }
    _currentExpression.add(CalculatorOperation(operationType, 0));
    _currentExpression
        .add(CalculatorOperation(CalculatorOperationType.number, 0));
    _lastOperation = operationType;
    _clearDisplay = true;
  }

  String _formatNumber(double number) {
    if (number == 0) {
      return '';
    }
    if (_isInteger(number)) {
      return number.toInt().toString();
    } else {
      return number.toString();
    }
  }

  bool _isInteger(double number) {
    return number == number.toInt();
  }

  void _calculate() {
    _currentExpression
        .add(CalculatorOperation(CalculatorOperationType.equals, 0));

    double currentValue = 0;
    CalculatorOperationType lastOperation = CalculatorOperationType.number;
    for (int i = 0; i < _currentExpression.length; i++) {
      CalculatorOperation operation = _currentExpression[i];
      if (operation.operation == CalculatorOperationType.number) {
        var currentNumber = operation.operand;
        if (currentValue == 0) {
          currentValue = operation.operand;
        } else {
          if (lastOperation == CalculatorOperationType.add) {
            currentValue = _add(currentValue, currentNumber);
          } else if (lastOperation == CalculatorOperationType.substract) {
            currentValue = _subtract(currentValue, currentNumber);
          } else if (lastOperation == CalculatorOperationType.multiply) {
            currentValue = _multiply(currentValue, currentNumber);
          } else if (lastOperation == CalculatorOperationType.divide) {
            currentValue = _divide(currentValue, currentNumber);
          }
        }
      } else {
        lastOperation = operation.operation;
      }
    }

    _currentExpression
        .add(CalculatorOperation(CalculatorOperationType.number, currentValue));
    _onCalculationCompleted(currentExpression);
    _currentExpression.clear();
    _clearDisplay = true;
  }
}
