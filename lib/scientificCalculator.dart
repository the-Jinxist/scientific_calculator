import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:scientific_calculator_open/size_config.dart';
import 'constants.dart';
import 'keyboard.dart';

String firstOperand = '0';
String secondOperand = '';
String operators = '';
String equation = '0';
String result = '';

class ScientificCalculator extends StatefulWidget {
  @override
  _ScientificCalculatorState createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  bool scientificKeyboard = true;

  final SizeConfig config = SizeConfig();

  String expression;
  double equationFontSize;
  double resultFontSize;

  @override
  void initState() {
    super.initState();
    initialise();

  }


  void initialise() {
    expression = '';
    equationFontSize = config.sp(27.0);
    resultFontSize = config.sp(40.0);
  }

  void _onPressed({String buttonText}) {
    switch (buttonText) {
      case CLEAR_ALL_SIGN:
        setState(() {
          _clear();
        });
        break;
      case DEL_SIGN:
        setState(() {
          equationFontSize = config.sp(27.0);
          resultFontSize = config.sp(40.0);
          equation = equation.substring(0, equation.length - 1);
          if (equation == '') equation = '0';
        });
        break;
      case EQUAL_SIGN:
        _result();
        break;
      default:
        _operands(buttonText);
    }
  }

  void _clear() {
    firstOperand = '0';
    secondOperand = '';
    operators = '';
    equation = '0';
    result = '';
    expression = '';
    equationFontSize = config.sp(27.0);
    resultFontSize = config.sp(40.0);
  }

  void _operands(value) {
    setState(() {
      equationFontSize = config.sp(40.0);
      resultFontSize = config.sp(27.0);
      if (value == POWER_SIGN) value = '^';
      if (value == MODULAR_SIGN) value = ' mód ';
      if (value == ARCSIN_SIGN) value = 'arcsin';
      if (value == ARCCOS_SIGN) value = 'arccos';
      if (value == ARCTAN_SIGN) value = 'arctan';
      if (value == DECIMAL_POINT_SIGN) {
        if (equation[equation.length - 1] == DECIMAL_POINT_SIGN) return;
      }
      equation == ZERO ? equation = value : equation += value;
    });
  }

  void _result() {
    setState(() {
      equationFontSize = config.sp(27.0);
      resultFontSize = config.sp(40.0);
      expression = equation;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      expression = expression.replaceAll(PI, '3.1415926535897932');
      expression = expression.replaceAll(E_NUM, 'e^1');
      expression = expression.replaceAll(SQUARE_ROOT_SIGN, 'sqrt');
      expression = expression.replaceAll(POWER_SIGN, '^');
      expression = expression.replaceAll(ARCSIN_SIGN, 'arcsin');
      expression = expression.replaceAll(ARCCOS_SIGN, 'arccos');
      expression = expression.replaceAll(ARCTAN_SIGN, 'arctan');
      expression = expression.replaceAll(LG_SIGN, 'log');
      expression = expression.replaceAll(' mód ', MODULAR_SIGN);
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (result == 'NaN') result = CALCULATE_ERROR;
        _isIntResult();
      } catch (e) {
        result = CALCULATE_ERROR;
      }
    });
  }

  _isIntResult() {
    if (result.toString().endsWith(".0")) {
      result = int.parse(result.toString().replaceAll(".0", "")).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Text('Scientific Calculator', style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 30),),
                Expanded(child: Container()),
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _inOutExpression(equation, equationFontSize),
                              result != ''
                                  ? _inOutExpression(result, resultFontSize)
                                  : Container(),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.black,),
                SizedBox(height: 10),
                Keyboard(
                  keyboardSigns: keyboardScientificCalculator,
                  onTap: _onPressed,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inOutExpression(text, size) {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Text(
        text is double ? text.toStringAsFixed(2) : text.toString(),
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: config.sp(size), color: Colors.black),
        textAlign: TextAlign.end,
      ),
    );
  }
}