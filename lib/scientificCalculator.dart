import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scientific_calculator_open/mathProvider.dart';
import 'package:scientific_calculator_open/size_config.dart';

import 'constants.dart';
import 'keyboard.dart';

class ScientificCalculator extends StatefulWidget {
  @override
  _ScientificCalculatorState createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {

  final SizeConfig config = SizeConfig();
  MathProvider provider;

  double equationFontSize;
  double resultFontSize;

  @override
  void initState() {
    equationFontSize = config.sp(40);
    resultFontSize = config.sp(27);
    super.initState();
  }

  void _onPressed({String buttonText}) {
    switch (buttonText) {
      case CLEAR_ALL_SIGN:
        provider.clear();
        setFontSizes();
        break;
      case DEL_SIGN:
        provider.delete();
        setFontSizes();
        break;
      case EQUAL_SIGN:
        provider.getResult();
        setFontSizes();
        break;
      default:
        provider.operands(buttonText);
        setFontSizes();
    }
  }



  @override
  Widget build(BuildContext context) {

    provider = Provider.of<MathProvider>(context);
//    provider.initialize();

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
                              _inOutExpression(provider.equation, equationFontSize),
                              provider.result != ''
                                  ? _inOutExpression(provider.result, resultFontSize)
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

  void setFontSizes() {
    setState(() {
      equationFontSize = provider.equationFontSize;
      resultFontSize = provider.resultFontSize;
    });
  }
}