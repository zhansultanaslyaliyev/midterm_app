import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());
class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Midterm 1'),),
        body: Column(
            children: <Widget>[

              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(equation, style: TextStyle(fontSize: equFontsize),),
              ),

              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  result, style: TextStyle(fontSize: resultFontsize),),
              ),

              Expanded(
                child: Divider(),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .75,
                    child: Table(
                        children: [
                          TableRow(
                              children: [
                                buildButton("C", 1, Colors.black26),
                                buildButton("DEL", 1, Colors.black26),
                                buildButton("÷", 1, Colors.black26),
                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("7", 1, Colors.black12),
                                buildButton("8", 1, Colors.black12),
                                buildButton("9", 1, Colors.black12),
                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("4", 1, Colors.black12),
                                buildButton("5", 1, Colors.black12),
                                buildButton("6", 1, Colors.black12),
                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton("1", 1, Colors.black12),
                                buildButton("2", 1, Colors.black12),
                                buildButton("3", 1, Colors.black12),
                              ]
                          ),
                          TableRow(
                              children: [
                                buildButton(".", 1, Colors.black12),
                                buildButton("0", 1, Colors.black12),
                                buildButton("00", 1, Colors.black12),
                              ]
                          )
                        ]
                    ),
                  ),

                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.25,
                      child: Table(
                          children: [
                            TableRow(
                                children: [
                                  buildButton("×", 1, Colors.orangeAccent),
                                ]
                            ),

                            TableRow(
                                children: [
                                  buildButton("-", 1, Colors.orangeAccent),
                                ]
                            ),
                            TableRow(
                                children: [
                                  buildButton("+", 1, Colors.orangeAccent),
                                ]
                            ),
                            TableRow(
                                children: [
                                  buildButton("=", 2, Colors.orange),
                                ]
                            )
                          ]

                      )
                  )

                ],
              )
            ]
        )

    );
  }

  Widget buildButton(String buttonText, double buttonHeight,
      Color buttonColor) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.black38,
                width: 1,
                style: BorderStyle.solid)
        ),
        padding: EdgeInsets.all(16.00),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),
        ),
      ),
    );
  }

  String equation = "0";
  String result = "0";
  String expression = "";
  double equFontsize = 38.0;
  double resultFontsize = 48.0;


  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equFontsize = 38.0;
        resultFontsize = 48.0;
      }
      else if (buttonText == "DEL") {
        equFontsize = 48.0;
        resultFontsize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "")
          equation = "0";
      }
      else if (buttonText == "=") {
        equFontsize = 38.0;
        resultFontsize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      }
      else {
        equFontsize = 48.0;
        resultFontsize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }
    });
  }
}