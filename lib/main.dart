import 'package:flutter/material.dart';
import 'package:scientific_calculator_open/scientificCalculator.dart';
import 'package:scientific_calculator_open/size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Caluclator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'Poppins-Extra-Bold',
            color: Colors.black,
            fontSize: 25
          ),
          headline2: TextStyle(
            fontFamily: 'Poppins-Bold',
            color: Colors.black,
            fontSize: 20
          ),
          bodyText1: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 17
          ),
          bodyText2: TextStyle(
            fontFamily: 'Poppins-Bold',
            color: Colors.black,
            fontSize: 14
          ),
        )
      ),
      home: Builder(builder: (context){
        SizeConfig.init(context, width: 360, height: 640, allowFontScaling: true);
        return ScientificCalculator();
      },),
    );
  }
}

