import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_calculator/utils/size.dart';

class NotebookCalculations extends StatelessWidget {
  const NotebookCalculations({super.key, required this.calculations});

  final List<String> calculations;

  @override
  Widget build(BuildContext context) {
    dynamic notebookWidth = getWidth(context) * 0.8;
    dynamic notebookHeight = getHeight(context) * 0.2;
    dynamic fontSize = notebookHeight * 0.1;

    var calculationsWidgets = calculations.map((c) => Container(
          width: notebookWidth,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
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
              fontSize: fontSize,
            ),
          ),
        ));

    return Container(
      height: notebookHeight,
      width: notebookWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(15.0),
        children: calculationsWidgets.toList(),
      ),
    );
  }
}
