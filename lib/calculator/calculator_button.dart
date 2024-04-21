import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator/calculator_engine.dart';
import 'package:simple_calculator/utils/size.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.selected = false});

  final String text;
  final VoidCallback onPressed;
  final bool selected;

  Color _getBackgroundColor() {
    if (text == CalculatorOperationType.equals.keyCharacter ||
        text == CalculatorOperationType.clear.keyCharacter) {
      return const Color.fromARGB(255, 248, 151, 52);
    } else if (selected) {
      return const Color.fromARGB(0, 227, 227, 227);
    } else {
      return const Color.fromARGB(255, 255, 255, 255);
    }
  }

  Color _getShadowColor() {
    if (text == CalculatorOperationType.equals.keyCharacter ||
        text == CalculatorOperationType.clear.keyCharacter) {
      return const Color.fromARGB(255, 223, 131, 56);
    } else {
      return const Color.fromARGB(255, 228, 229, 231);
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic height = getHeight(context);
    dynamic width = getWidth(context);

    var buttonWidth = text == '0' ? width * 0.3 : width * 0.145;
    var buttonHeight = height * 0.07;
    var buttonPadding = EdgeInsets.fromLTRB(0, 10, 0, 10);

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: _getShadowColor(),
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: buttonPadding,
          backgroundColor: _getBackgroundColor(),
          foregroundColor: Colors.black,
          textStyle: TextStyle(
            fontSize: height * 0.03,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(text),
      ),
    );
  }
}
