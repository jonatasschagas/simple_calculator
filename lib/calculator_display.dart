import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key, this.displayText = ''});

  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 156, 196, 200),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 121, 152, 155).withOpacity(1),
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        displayText,
        style: GoogleFonts.orbitron(
          fontSize: 50,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
