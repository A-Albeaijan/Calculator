import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../widgets/buttons.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var userInput = '';
  var answer = '';
  final List<String> buttonText = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  bool mode = true;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(20),
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      primary: mode == false ? const Color(0xff272B33) : Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
    double height = MediaQuery.of(context).size.height;
    double width = (MediaQuery.of(context).size.width);

    //

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: mode == false ? const Color(0xff22252D) : Colors.grey[100],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  color: mode == true ? Colors.black54 : Colors.white,
                  padding: const EdgeInsets.all(10),
                  icon: Icon(
                    mode == true
                        ? Icons.nightlight_outlined
                        : Icons.wb_sunny_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      mode = !mode;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: height * 0.25,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          userInput,
                          style: TextStyle(
                              fontSize: 25,
                              color: mode == false
                                  ? Colors.grey[400]
                                  : Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      answer,
                      style: TextStyle(
                          fontSize: 30,
                          color: mode == false ? Colors.white : Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        mode == false ? const Color(0xff292D36) : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: GridView.builder(
                    itemCount: buttonText.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // C Button
                      if (index == 0) {
                        return Buttons(
                          tap: () {
                            setState(() {
                              userInput = '';
                              answer = '0';
                            });
                          },
                          mode: mode,
                          text: buttonText[index],
                          color: const Color(0xffD76061),
                          style: style,
                        );
                      }

                      // +/- button
                      else if (index == 1) {
                        return Buttons(
                          tap: () {},
                          mode: mode,
                          text: buttonText[index],
                          color: const Color(0xffD76061),
                          style: style,
                        );
                      }
                      // % Button
                      else if (index == 2) {
                        return Buttons(
                          tap: () {
                            setState(() {
                              userInput += buttonText[index];
                            });
                          },
                          mode: mode,
                          text: buttonText[index],
                          color: Color(0xffD76061),
                          style: style,
                        );
                      }
                      // Delete Button
                      else if (index == 3) {
                        return Buttons(
                          tap: () {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            });
                          },
                          mode: mode,
                          text: buttonText[index],
                          color: const Color(0xffD76061),
                          style: style,
                        );
                      }
                      // Equal Button
                      else if (index == 18) {
                        return Buttons(
                          tap: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          mode: mode,
                          text: buttonText[index],
                          color: const Color(0xffD76061),
                          style: style,
                        );
                      }

                      //  other buttons
                      else {
                        return Buttons(
                          tap: () {
                            setState(() {
                              userInput += buttonText[index];
                            });
                          },
                          text: buttonText[index],
                          color: buttonText[index] == '+' ||
                                  buttonText[index] == '/' ||
                                  buttonText[index] == 'x' ||
                                  buttonText[index] == '-'
                              ? const Color(0xffD76061)
                              : Colors.teal,
                          mode: mode,
                          style: style,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
