import 'package:flutter/material.dart';
import 'package:simple_calculator/calculator_engine.dart';
import 'package:simple_calculator/calculator_keyboard.dart';
import 'package:simple_calculator/calculator_display.dart';

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
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: Center(
          child: Container(
            width: 380,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 130, 128, 128),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 82, 82, 82).withOpacity(1),
                  spreadRadius: 1,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                CalculatorDisplay(displayText: calculatorEngine.display),
                const SizedBox(height: 20),
                CalculatorKeyboard(onKeyPressed: onKeyPressed),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
