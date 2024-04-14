import 'dart:collection';

enum CalculatorOperationType {
  add('+'),
  substract('-'),
  multiply('x'),
  divide('+'),
  equals('='),
  number('N');

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
  final Queue<_CalculatorOperation> _inputQueue = Queue();

  String _currentDisplay = '0';
  bool _clearDisplay = true;

  String get display => _currentDisplay;

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
    if (input == '=') {
      _calculate();
    } else {
      CalculatorOperationType operationType = _getOperationType(input);

      if (operationType == CalculatorOperationType.number) {
        if (_clearDisplay) {
          _currentDisplay = '';
          _clearDisplay = false;
        }
        // append the number to the current display
        _currentDisplay += input;
      } else {
        // scenario where the user enters an operation after an operation
        if (_clearDisplay && _inputQueue.isNotEmpty) {
          // remove the last operation
          _inputQueue.removeLast();
          // add the operation to the queue
          _inputQueue.add(_CalculatorOperation(operationType, 0));
        } else {
          _clearDisplay = true;
          // add the number to the queue
          _inputQueue.add(_CalculatorOperation(
              CalculatorOperationType.number, double.parse(_currentDisplay)));
          // add the operation to the queue
          _inputQueue.add(_CalculatorOperation(operationType, 0));
        }
      }
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
    } else {
      return CalculatorOperationType.number;
    }
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
    _clearDisplay = true;
  }
}
