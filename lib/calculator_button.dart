import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator_engine.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: (text == CalculatorOperationType.equals.keyCharacter
                ? const Color.fromARGB(127, 236, 115, 22)
                : const Color.fromARGB(153, 227, 227, 227)),
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          backgroundColor: text == CalculatorOperationType.equals.keyCharacter
              ? const Color.fromARGB(255, 236, 115, 22)
              : const Color.fromARGB(255, 227, 227, 227),
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
