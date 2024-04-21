import 'package:flutter/material.dart';

import 'package:simple_calculator/calculator/calculator_button.dart';
import 'package:simple_calculator/calculator/calculator_engine.dart';
import 'package:simple_calculator/utils/size.dart';

class CalculatorKeyboard extends StatelessWidget {
  const CalculatorKeyboard(
      {super.key, required this.onKeyPressed, this.selectedKey = ''});

  final void Function(String) onKeyPressed;
  final String selectedKey;

  CalculatorButton _renderButton(String key) {
    if (key == selectedKey) print('selectedKey: $selectedKey');
    return CalculatorButton(
      text: key,
      onPressed: () {
        onKeyPressed(key);
      },
      selected: key == selectedKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic paddingBetweenRows = getHeight(context) * 0.020;

    var firstRow = [
      CalculatorOperationType.clear.keyCharacter,
      CalculatorOperationType.sign.keyCharacter,
      CalculatorOperationType.percent.keyCharacter,
      CalculatorOperationType.divide.keyCharacter,
    ].map((e) => _renderButton(e)).toList();

    var secondRow = [
      '7',
      '8',
      '9',
      CalculatorOperationType.multiply.keyCharacter,
    ].map((e) => _renderButton(e)).toList();

    var thirdRow = [
      '4',
      '5',
      '6',
      CalculatorOperationType.substract.keyCharacter,
    ].map((e) => _renderButton(e)).toList();

    var fourthRow = [
      '1',
      '2',
      '3',
      CalculatorOperationType.add.keyCharacter,
    ].map((e) => _renderButton(e)).toList();

    var fifthRow = [
      '0',
      CalculatorOperationType.dot.keyCharacter,
      CalculatorOperationType.equals.keyCharacter,
    ].map((e) => _renderButton(e)).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: paddingBetweenRows),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: firstRow,
        ),
        SizedBox(height: paddingBetweenRows), // Add this line (1)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: secondRow,
        ),
        SizedBox(height: paddingBetweenRows), // Add this line (2)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: thirdRow,
        ),
        SizedBox(height: paddingBetweenRows), // Add this line (3)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: fourthRow,
        ),
        SizedBox(height: paddingBetweenRows), // Add this line (3)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: fifthRow,
        ),
      ],
    );
  }
}
