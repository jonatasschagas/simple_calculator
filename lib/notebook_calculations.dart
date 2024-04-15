import 'package:flutter/material.dart';

class NotebookCalculations extends StatelessWidget {
  const NotebookCalculations({super.key, required this.calculations});

  final List<String> calculations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: calculations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(calculations[index]),
        );
      },
    );
  }
}
