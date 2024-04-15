import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator_engine.dart';

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
    if (text == CalculatorOperationType.equals.keyCharacter) {
      return const Color.fromARGB(255, 236, 115, 22);
    } else if (selected) {
      return const Color.fromARGB(0, 227, 227, 227);
    } else {
      return const Color.fromARGB(255, 227, 227, 227);
    }
  }

  Color _getShadowColor() {
    if (text == CalculatorOperationType.equals.keyCharacter) {
      return const Color.fromARGB(127, 236, 115, 22);
    } else {
      return const Color.fromARGB(153, 227, 227, 227);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
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
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          backgroundColor: _getBackgroundColor(),
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 50,
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
