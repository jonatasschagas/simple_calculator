import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator/calculator_engine.dart';
import 'package:simple_calculator/calculator/calculator.dart';
import 'package:simple_calculator/notebook/notebook_calculations.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  final CalculatorEngine calculatorEngine = CalculatorEngine();

  void onKeyPressed(String key) {
    setState(() {
      calculatorEngine.handleInput(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            width: 500,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/table-top.jpeg'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Calculator(
                  calculations: calculatorEngine.calculations,
                  onKeyPressed: onKeyPressed,
                  lastOperationKey: calculatorEngine.lastOperationKey,
                  displayText: calculatorEngine.display,
                ),
                const SizedBox(height: 35),
                NotebookCalculations(calculations: [
                  calculatorEngine.currentExpression,
                  ...calculatorEngine.calculations.reversed,
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
