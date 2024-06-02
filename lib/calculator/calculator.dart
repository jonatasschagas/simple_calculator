import 'package:flutter/material.dart';

import 'package:simple_calculator/calculator/calculator_keyboard.dart';
import 'package:simple_calculator/calculator/calculator_display.dart';
import 'package:simple_calculator/utils/size.dart';

class Calculator extends StatelessWidget {
  const Calculator(
      {super.key,
      required this.calculations,
      required this.onKeyPressed,
      required this.lastOperationKey,
      required this.displayText});

  final List<String> calculations;
  final void Function(String) onKeyPressed;
  final String lastOperationKey;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    dynamic calculatorWidth = getWidth(context) * 0.8;
    dynamic calculatorHeight = getHeight(context) * 0.64;

    return Container(
      width: calculatorWidth,
      height: calculatorHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 97, 98, 104),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 82, 83, 89).withOpacity(1),
            spreadRadius: 1,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 35, 35, 40),
        child: Column(children: [
          CalculatorDisplay(
            displayText: displayText,
          ),
          const SizedBox(height: 10),
          CalculatorKeyboard(
            onKeyPressed: onKeyPressed,
            selectedKey: lastOperationKey,
          ),
        ]),
      ),
    );
  }
}
