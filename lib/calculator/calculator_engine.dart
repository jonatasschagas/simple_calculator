import 'dart:collection';

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
  dot('.');

  const CalculatorOperationType(this._keyCharacter);

  final String _keyCharacter;

  String get keyCharacter => _keyCharacter;
}

class _CalculatorOperation {
  CalculatorOperationType operation;
  double operand;

  _CalculatorOperation(this.operation, this.operand);
}

class CalculatorEngine {
  CalculatorEngine();

  final Queue<_CalculatorOperation> _inputQueue = Queue();

  String _currentDisplay = '0';
  bool _expectNewNumber = true;
  CalculatorOperationType _lastOperation = CalculatorOperationType.number;
  final List<String> _currentExpression = [];
  final List<String> _calculations = [];
  final List<CalculatorOperationType> _operations = [
    CalculatorOperationType.add,
    CalculatorOperationType.substract,
    CalculatorOperationType.multiply,
    CalculatorOperationType.divide
  ];

  String get display => _currentDisplay;
  String get lastOperationKey => _lastOperation.keyCharacter;
  String get currentExpression => _currentExpression.join(" ");
  List<String> get calculations => _calculations;

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

    if (_expectNewNumber) {
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
    _currentDisplay = '0';
    _expectNewNumber = true;
    _lastOperation = CalculatorOperationType.number;
    _currentExpression.clear();
  }

  void _changeSign() {
    bool isNegative = _currentDisplay.startsWith('-');
    if (_currentDisplay.startsWith('-')) {
      _currentDisplay = _currentDisplay.substring(1);
    } else {
      _currentDisplay = '-$_currentDisplay';
    }

    if (!isNegative) {
      for (int i = _currentExpression.length - 1; i >= 0; i--) {
        CalculatorOperationType operationType =
            _getOperationType(_currentExpression[i]);
        if (_operations.contains(operationType)) {
          _currentExpression.insert(i, '-');
        }
      }
    }

    _currentExpression.removeLast();
    _currentExpression.add(_currentDisplay);
  }

  void _percent() {
    double value = double.parse(_currentDisplay);
    value = value / 100;
    _currentDisplay = value.toString();
  }

  void _processNumber(String input) {
    if (input == CalculatorOperationType.dot.keyCharacter &&
        _currentDisplay.contains(CalculatorOperationType.dot.keyCharacter)) {
      // if the current display already contains a dot, return
      return;
    }

    if (_expectNewNumber) {
      _currentDisplay = '';
      _expectNewNumber = false;
    }
    // append the number to the current display
    _currentDisplay += input;
    _currentExpression.add(input);
  }

  void _processOperation(CalculatorOperationType operationType) {
    // scenario where the user enters an operation after an operation
    if (_expectNewNumber && _inputQueue.isNotEmpty) {
      // remove the last operation
      _inputQueue.removeLast();
      // add the operation to the queue
      _inputQueue.add(_CalculatorOperation(operationType, 0));
    } else {
      _expectNewNumber = true;
      // add the number to the queue
      _inputQueue.add(_CalculatorOperation(
          CalculatorOperationType.number, double.parse(_currentDisplay)));
      // add the operation to the queue
      _inputQueue.add(_CalculatorOperation(operationType, 0));
    }
    _lastOperation = operationType;
    _currentExpression.add(operationType.keyCharacter);
  }

  void _calculate() {
    _inputQueue.add(_CalculatorOperation(
        CalculatorOperationType.number, double.parse(_currentDisplay)));

    double currentValue = 0;
    CalculatorOperationType lastOperation = CalculatorOperationType.number;
    while (_inputQueue.isNotEmpty) {
      _CalculatorOperation operation = _inputQueue.removeFirst();

      if (operation.operation == CalculatorOperationType.number) {
        if (currentValue == 0) {
          currentValue = operation.operand;
        } else {
          double valueToUse = operation.operand;
          switch (lastOperation) {
            case CalculatorOperationType.add:
              currentValue = _add(currentValue, valueToUse);
              break;
            case CalculatorOperationType.substract:
              currentValue = _subtract(currentValue, valueToUse);
              break;
            case CalculatorOperationType.multiply:
              currentValue = _multiply(currentValue, valueToUse);
              break;
            case CalculatorOperationType.divide:
              currentValue = _divide(currentValue, valueToUse);
              break;
            default:
              break;
          }
        }
      } else {
        lastOperation = operation.operation;
      }
    }

    if (currentValue is int || currentValue == currentValue.roundToDouble()) {
      _currentDisplay = ((currentValue.round())).toString();
    } else {
      _currentDisplay = currentValue.toString();
    }

    var currentExpressionSerialized = _currentExpression.join(" ");
    _calculations.add('$currentExpressionSerialized = $_currentDisplay');

    _expectNewNumber = true;
    _lastOperation = CalculatorOperationType.number;
    _currentExpression.clear();
  }
}
