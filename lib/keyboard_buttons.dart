import 'package:scientific_calculator_open/size_config.dart';

import 'constants.dart';
import 'package:flutter/material.dart';

typedef void CallbackButtonTap({String buttonText});

class KeyboardButtons extends StatelessWidget {
  KeyboardButtons({this.buttons, @required this.onTap});

  final String buttons;
  final CallbackButtonTap onTap;

  bool _colorTextButtons() {
    return (buttons == DEL_SIGN ||
        buttons == DECIMAL_POINT_SIGN ||
        buttons == CLEAR_ALL_SIGN ||
        buttons == MODULAR_SIGN ||
        buttons == PLUS_SIGN ||
        buttons == MINUS_SIGN ||
        buttons == MULTIPLICATION_SIGN ||
        buttons == DIVISION_SIGN ||
        buttons == EXCHANGE_CALCULATOR ||
        buttons == PI ||
        buttons == SQUARE_ROOT_SIGN ||
        buttons == POWER_SIGN ||
        buttons == LN_SIGN ||
        buttons == LG_SIGN ||
        buttons == SIN_SIGN ||
        buttons == COS_SIGN ||
        buttons == TAN_SIGN ||
        buttons == RAD_SIGN ||
        buttons == DEG_SIGN ||
        buttons == ARCSIN_SIGN ||
        buttons == ARCCOS_SIGN ||
        buttons == ARCTAN_SIGN ||
        buttons == LN2_SIGN ||
        buttons == E_NUM ||
        buttons == LEFT_QUOTE_SIGN ||
        buttons == RIGHT_QUOTE_SIGN);
  }

  bool _fontSize(){
    return (
        buttons == LN_SIGN ||
        buttons == LG_SIGN ||
        buttons == SIN_SIGN ||
        buttons == COS_SIGN ||
        buttons == TAN_SIGN ||
        buttons == RAD_SIGN ||
        buttons == DEG_SIGN ||
        buttons == ARCSIN_SIGN ||
        buttons == ARCCOS_SIGN ||
        buttons == ARCTAN_SIGN ||
        buttons == LN2_SIGN ||
        buttons == LEFT_QUOTE_SIGN ||
        buttons == RIGHT_QUOTE_SIGN
    );
  }

  @override
  Widget build(BuildContext context) {

    final SizeConfig config = SizeConfig();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () => onTap(buttonText: buttons),
          child: Container(
            height: config.sh(30),
            decoration: BoxDecoration(
              color: (buttons == EQUAL_SIGN)
                  ? Colors.amber
                  : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: (buttons == EQUAL_SIGN) ? Border.all(color: Colors.black, width: 1.5)
                      : Border.all(color: Colors.amber, width: 1.5) ,
            ),

            alignment: Alignment.center,
            child: Center(
              child: Text(
                buttons,
                style: Theme.of(context)
                  .textTheme.bodyText1.copyWith(
                  color: (_colorTextButtons()) ? Colors.amber :
                          (buttons == EQUAL_SIGN) ? Colors.white : Colors.black,
                  fontSize: _fontSize() ? config.sp(15): config.sp(17)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
