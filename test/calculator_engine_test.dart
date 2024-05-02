import 'package:simple_calculator/calculator/calculator_engine.dart';
import 'package:test/test.dart';

void main() {
  group('Test basic operations', () {
    test('CalculatorEngine should add numbers', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '1 + 2 = 3');
      };

      calculatorEngine.handleInput('1');
      calculatorEngine.handleInput(CalculatorOperationType.add.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });

    test('CalculatorEngine should subtract numbers', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '5 - 2 = 3');
      };

      calculatorEngine.handleInput('5');
      calculatorEngine
          .handleInput(CalculatorOperationType.substract.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });

    test('CalculatorEngine should multiply numbers', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '5 * 2 = 10');
      };

      calculatorEngine.handleInput('5');
      calculatorEngine
          .handleInput(CalculatorOperationType.multiply.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });

    test('CalculatorEngine should divide numbers', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '6 ÷ 2 = 3');
      };

      calculatorEngine.handleInput('6');
      calculatorEngine.handleInput(CalculatorOperationType.divide.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });

    test('CalculatorEngine should handle decimal numbers', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '0.1 + 0.2 = 0.3');
      };

      calculatorEngine.handleInput('0');
      calculatorEngine.handleInput(CalculatorOperationType.dot.keyCharacter);
      calculatorEngine.handleInput('1');
      calculatorEngine.handleInput(CalculatorOperationType.add.keyCharacter);
      calculatorEngine.handleInput('0');
      calculatorEngine.handleInput(CalculatorOperationType.dot.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });
  });

  group('Test advanced operations', () {
    test('CalculatorEngine should handle multiple operations', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '( 6 ÷ 2 ) x 3 + 1 = 10');
      };

      calculatorEngine.handleInput('6');
      calculatorEngine.handleInput(CalculatorOperationType.divide.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine
          .handleInput(CalculatorOperationType.multiply.keyCharacter);
      calculatorEngine.handleInput('3');
      calculatorEngine.handleInput(CalculatorOperationType.add.keyCharacter);
      calculatorEngine.handleInput('1');
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });

    test('CalculatorEngine should handle sign change', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '( 6 + -10 + 2 ) ÷ -2 = 1');
      };

      calculatorEngine.handleInput('6');
      calculatorEngine.handleInput(CalculatorOperationType.add.keyCharacter);
      calculatorEngine.handleInput('10');
      calculatorEngine.handleInput(CalculatorOperationType.sign.keyCharacter);
      calculatorEngine.handleInput(CalculatorOperationType.add.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.divide.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.sign.keyCharacter);
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });

    test('CalculatorEngine should handle percent', () {
      final calculatorEngine = CalculatorEngine();
      calculatorEngine.onCalculationCompletedHandler = (String result) {
        expect(result, '( 6 + 0.1 + 2 ) ÷ 0.01 = 810');
      };

      calculatorEngine.handleInput('6');
      calculatorEngine.handleInput(CalculatorOperationType.add.keyCharacter);
      calculatorEngine.handleInput('10');
      calculatorEngine
          .handleInput(CalculatorOperationType.percent.keyCharacter);
      calculatorEngine.handleInput(CalculatorOperationType.add.keyCharacter);
      calculatorEngine.handleInput('2');
      calculatorEngine.handleInput(CalculatorOperationType.divide.keyCharacter);
      calculatorEngine.handleInput('1');
      calculatorEngine
          .handleInput(CalculatorOperationType.percent.keyCharacter);
      calculatorEngine.handleInput(CalculatorOperationType.equals.keyCharacter);
    });
  });
}
