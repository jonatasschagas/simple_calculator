
import 'package:decimal/decimal.dart';

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
  closeParenthesis(')'),
  empty('');

  const CalculatorOperationType(this._keyCharacter);

  final String _keyCharacter;

  String get keyCharacter => _keyCharacter;
}

class CalculatorOperation {
  CalculatorOperationType operation;
  Decimal operand;

  CalculatorOperation(this.operation, this.operand);
}

class CalculatorEngine {
  CalculatorEngine();

  final List<CalculatorOperation> _currentExpression = [];
  bool _clearDisplay = false;
  bool _nextNumberShouldBeDecimal = false;
  CalculatorOperationType _lastOperation = CalculatorOperationType.number;
  Decimal _lastResult = Decimal.zero;

  final List<CalculatorOperationType> _operations = [
    CalculatorOperationType.add,
    CalculatorOperationType.substract,
    CalculatorOperationType.multiply,
    CalculatorOperationType.divide
  ];

  String get display => _getLastNumberInCurrentExpression();
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

  Decimal _add(Decimal a, Decimal b) {
    return a + b;
  }

  Decimal _subtract(Decimal a, Decimal b) {
    return a - b;
  }

  Decimal _multiply(Decimal a, Decimal b) {
    return a * b;
  }

  Decimal _divide(Decimal a, Decimal b) {
    return (a.toRational() / b.toRational()).toDecimal();
  }

  void handleInput(String input) {
    if (_clearDisplay) {
      if (_currentExpression.isNotEmpty) {
        _currentExpression.last.operand = Decimal.zero;
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

    _currentExpression.last.operand = _currentExpression.last.operand * Decimal.parse('-1');
  }

  void _percent() {
    if (_currentExpression.isEmpty ||
        _currentExpression.last.operation != CalculatorOperationType.number) {
      return;
    }

    _currentExpression.last.operand = (_currentExpression.last.operand.toRational() / Decimal.fromInt(100).toRational()).toDecimal();
  }

  void _processNumber(String input) {
    if (input == CalculatorOperationType.dot.keyCharacter) {
      // current number is already a decimal
      if (!_isInteger(_currentExpression.last.operand)) {
        return;
      } else {
        _nextNumberShouldBeDecimal = true;
        return;
      }
    }

    if (_nextNumberShouldBeDecimal) {
      _currentExpression.last.operand += Decimal.parse('0.$input');
      _nextNumberShouldBeDecimal = false;
      return;
    }

    if (_currentExpression.isNotEmpty) {
      // assumes the last element in the expression is number
      var currentNumber = _currentExpression.last.operand;
      _currentExpression.last.operand =
          currentNumber * Decimal.ten + Decimal.parse(input);
    } else {
      _currentExpression.add(CalculatorOperation(
          CalculatorOperationType.number, Decimal.parse(input)));
    }
  }

  void _processOperation(CalculatorOperationType operationType) {
    if (_currentExpression.length >= 3 &&
        (operationType == CalculatorOperationType.multiply ||
            operationType == CalculatorOperationType.divide)) {
      // add parentheses to the current expression
      _currentExpression.insert(
          0, CalculatorOperation(CalculatorOperationType.openParenthesis, Decimal.zero));
      _currentExpression.add(
          CalculatorOperation(CalculatorOperationType.closeParenthesis, Decimal.zero));
    }
    _currentExpression.add(CalculatorOperation(operationType, Decimal.zero));
    _currentExpression
        .add(CalculatorOperation(CalculatorOperationType.number, Decimal.zero));
    _lastOperation = operationType;
  }

  String _formatNumber(Decimal number) {
    if (number == Decimal.zero) {
      return '';
    }
    return number.toString();
  }

  String _getLastNumberInCurrentExpression () {
    if (_currentExpression.isEmpty) {
      if (_lastResult != Decimal.zero) {
        return _lastResult.toString();
      }
      return '';
    }

    Decimal lastNumber = _currentExpression.reversed.firstWhere(
      (op) => op.operation == CalculatorOperationType.number && op.operand != Decimal.zero,
      orElse: () => CalculatorOperation(CalculatorOperationType.empty, Decimal.zero),
    ).operand;

    return lastNumber.toString();
  }

  bool _isInteger(Decimal decimal) {
    return decimal == decimal.truncate();
  }

  void _calculate() {
    _currentExpression
        .add(CalculatorOperation(CalculatorOperationType.equals, Decimal.zero));

    Decimal currentValue = Decimal.zero;
    CalculatorOperationType lastOperation = CalculatorOperationType.number;
    for (int i = 0; i < _currentExpression.length; i++) {
      CalculatorOperation operation = _currentExpression[i];
      if (operation.operation == CalculatorOperationType.number) {
        var currentNumber = operation.operand;
        if (currentValue == Decimal.zero) {
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
    _lastResult = currentValue;
    _clear();
  }
}
