import 'package:calculatorapp/widget/customButton.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // For expression evaluation

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  // Append text to the expression
  void _appendValue(String value) {
    setState(() {
      controller.text += value;
    });
  }

  // Clear the input field
  void _clear() {
    setState(() {
      controller.text = '';
    });
  }

  // Evaluate the expression
  void _calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(controller.text);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        controller.text = eval.toString();
      });
    } catch (e) {
      setState(() {
        controller.text = 'Error';
      });
    }
  }

  void _backspace() {
    setState(() {
      if (controller.text.isNotEmpty) {
        controller.text = controller.text.substring(
          0,
          controller.text.length - 1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(hintText: '0'),
              style: const TextStyle(color: Colors.white, fontSize: 30),
              cursorColor: Colors.white,
              textAlign: TextAlign.right,
              readOnly: true,
            ),
            const SizedBox(height: 10),
            _buildRow(['AC', '%', 'Del', '/']),
            const SizedBox(height: 10),
            _buildRow(['7', '8', '9', '*']),
            const SizedBox(height: 10),
            _buildRow(['4', '5', '6', '-']),
            const SizedBox(height: 10),
            _buildRow(['1', '2', '3', '+']),
            const SizedBox(height: 10),
            _buildRow(['00', '0', '.', '=']),

            // Clear button
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<String> texts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          texts.map((text) {
            Color buttonColor;

            // Set custom colors for '=' and 'Del'
            if (text == '=') {
              buttonColor = Colors.orange;
            } else {
              buttonColor = const Color.fromARGB(212, 27, 25, 25);
            }

            return Custombuttons(
              text: text,
              color: buttonColor,
              textColor: Colors.white,
              onPressed: () {
                if (text == '=') {
                  _calculate();
                } else if (text == 'AC') {
                  _clear();
                } else if (text == 'Del') {
                  _backspace();
                } else {
                  _appendValue(text);
                }
              },
            );
          }).toList(),
    );
  }
}
