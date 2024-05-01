import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator/calculator_engine.dart';
import 'package:simple_calculator/calculator/calculator.dart';
import 'package:simple_calculator/calculator/calculator_engine2.dart';
import 'package:simple_calculator/notebook/notebook_calculations.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  //final CalculatorEngine calculatorEngine = CalculatorEngine();
  final CalculatorEngine2 calculatorEngine = CalculatorEngine2();

  void initState() {
    super.initState();
    calculatorEngine.onCalculationCompletedHandler =
        onCalculationCompletedHandler;
  }

  List<String> _calculations = [];

  void onCalculationCompletedHandler(String calculation) {
    setState(() {
      _calculations.add(calculation);
    });
  }

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
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/table-top.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Calculator(
                  //calculations: calculatorEngine.calculations,
                  calculations: _calculations,
                  onKeyPressed: onKeyPressed,
                  lastOperationKey: calculatorEngine.lastOperationKey,
                  displayText: calculatorEngine.display,
                ),
                const SizedBox(height: 35),
                NotebookCalculations(calculations: [
                  calculatorEngine.currentExpression,
                  //...calculatorEngine.calculations.reversed,
                  ..._calculations.reversed,
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
