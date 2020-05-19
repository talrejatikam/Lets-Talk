import 'package:chatapp/widgets/color.dart';
import 'package:flutter/material.dart';

Widget appName(){
  return
    RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
        children: <TextSpan>[
          TextSpan(text: 'Let\'s', style: TextStyle(color: Color(0xffF8F8Ff))),
          TextSpan(text: ' Talk', style: TextStyle(color: Color(0xff6600FF	))),
        ],
      ),
    );
}

InputDecoration textFiled(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: hintColor
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: borderFocusedColor)
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: borderEnabledColor)
    )
  );
}

TextStyle textStyle(){
  return TextStyle(
    color: textFieldColor,
    fontSize: 16
  );
}

TextStyle mediumTextStyle(){
  return
    TextStyle(fontSize: 17, color: Color(0xffffffff),fontWeight: FontWeight.w500);
}
TextStyle buttonTextStyle(){
  return TextStyle(color: borderFocusedColor,fontSize: 17, fontWeight: FontWeight.w700);
}