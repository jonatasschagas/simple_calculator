import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotebookCalculations extends StatelessWidget {
  const NotebookCalculations({super.key, required this.calculations});

  final List<String> calculations;

  @override
  Widget build(BuildContext context) {
    var calculationsWidgets = calculations.map((c) => Container(
          width: 400,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border(
              bottom: BorderSide(
                width: 1.5,
                color: Colors.blue.shade200,
              ),
            ),
          ),
          child: Text(
            c,
            style: GoogleFonts.cedarvilleCursive(
              fontSize: 20,
            ),
          ),
        ));

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(15.0),
      children: calculationsWidgets.toList(),
    );
  }
}
