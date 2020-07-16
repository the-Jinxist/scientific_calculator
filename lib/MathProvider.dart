import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:scientific_calculator_open/size_config.dart';
import 'constants.dart';

class MathProvider extends ChangeNotifier{

  final SizeConfig config = SizeConfig();

  String _firstOperand = '0';
  String _secondOperand = '';
  String _operators = '';
  String _equation = '0';
  String _result = '';
  String _expression = '';

  double _equationFontSize;
  double _resultFontSize;

  bool _isInitialized = false;


  bool get isInitialized => _isInitialized;

  set isInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  double get equationFontSize => _equationFontSize;

  set equationFontSize(double value) {
    _equationFontSize = value;
    notifyListeners();
  }

  String get expression => _expression;

  set expression(String value) {
    _expression = value;
    notifyListeners();
  }

  String get firstOperand => _firstOperand;

  set firstOperand(String value) {
    _firstOperand = value;
    notifyListeners();
  }

  String get secondOperand => _secondOperand;

  set secondOperand(String value) {
    _secondOperand = value;
    notifyListeners();
  }

  String get result => _result;

  set result(String value) {
    _result = value;
    notifyListeners();
  }

  String get equation => _equation;

  set equation(String value) {
    _equation = value;
    notifyListeners();
  }

  String get operators => _operators;

  set operators(String value) {
    _operators = value;
    notifyListeners();
  }

  double get resultFontSize => _resultFontSize;

  set resultFontSize(double value) {
    _resultFontSize = value;
    notifyListeners();
  }

  void delete(){

    equationFontSize = config.sp(27.0);
    resultFontSize = config.sp(40.0);
    equation = equation.substring(0, equation.length - 1);
    if (equation == '') equation = '0';
  }

  void clear() {
    firstOperand = '0';
    secondOperand = '';
    operators = '';
    equation = '0';
    result = '';
    expression = '';
    equationFontSize = config.sp(27.0);
    resultFontSize = config.sp(40.0);
  }

  void operands(value) {
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
  }

  void initialized(){
    if(!isInitialized){
      expression = '';
      equationFontSize = config.sp(27.0);
      resultFontSize = config.sp(40.0);

      isInitialized = true;
    }
  }

  void getResult() {
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
  }

  _isIntResult() {
    if (result.toString().endsWith(".0")) {
      result = int.parse(result.toString().replaceAll(".0", "")).toString();
    }
  }




}