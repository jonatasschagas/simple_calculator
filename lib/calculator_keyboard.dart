import 'package:flutter/material.dart';

import 'package:simple_calculator/calculator_button.dart';
import 'package:simple_calculator/calculator_engine.dart';

class CalculatorKeyboard extends StatelessWidget {
  const CalculatorKeyboard({super.key, required this.onKeyPressed});

  final void Function(String) onKeyPressed;

  @override
  Widget build(BuildContext context) {
    var firstRow =
        ['7', '8', '9', CalculatorOperationType.divide.keyCharacter].map((e) {
      return CalculatorButton(
        text: e,
        onPressed: () {
          onKeyPressed(e);
        },
      );
    }).toList();

    var secondRow =
        ['4', '5', '6', CalculatorOperationType.multiply.keyCharacter].map((e) {
      return CalculatorButton(
        text: e,
        onPressed: () {
          onKeyPressed(e);
        },
      );
    }).toList();

    var thirdRow = [
      '1',
      '2',
      '3',
      CalculatorOperationType.substract.keyCharacter
    ].map((e) {
      return CalculatorButton(
        text: e,
        onPressed: () {
          onKeyPressed(e);
        },
      );
    }).toList();

    var fourthRow = [
      '0',
      '.',
      CalculatorOperationType.add.keyCharacter,
      CalculatorOperationType.equals.keyCharacter
    ].map((e) {
      return CalculatorButton(
        text: e,
        onPressed: () {
          onKeyPressed(e);
        },
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: firstRow,
        ),
        const SizedBox(height: 20), // Add this line (1)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: secondRow,
        ),
        const SizedBox(height: 20), // Add this line (2)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: thirdRow,
        ),
        const SizedBox(height: 20), // Add this line (3)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: fourthRow,
        ),
      ],
    );
  }
}
