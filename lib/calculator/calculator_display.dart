import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key, this.displayText = ''});

  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 400,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 207, 213, 225),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 196, 200, 212).withOpacity(1),
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        displayText,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.orbitron(
          fontSize: 30,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
