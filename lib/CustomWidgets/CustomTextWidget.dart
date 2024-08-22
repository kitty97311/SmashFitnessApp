import 'package:exercise_app/Themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextWidget {
  boldText({dynamic text, double? size, Color? color, TextAlign? alignment}) {
    return Container(
        child: Text(
      text is Map ? text[LANGUAGE_TYPE] : text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontFamily: "Bold",
      ),
      textAlign: alignment ?? TextAlign.start,
    ));
  }

  regularText(
      {dynamic text, double? size, Color? color, TextAlign? alignment}) {
    return Container(
        child: Text(
      text is Map ? text[LANGUAGE_TYPE] : text,
      style: TextStyle(fontSize: size, color: color, fontFamily: "Regular"),
      textAlign: alignment ?? TextAlign.start,
    ));
  }

  lightText({dynamic text, double? size, Color? color}) {
    return Container(
        child: Text(
      text is Map ? text[LANGUAGE_TYPE] : text,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w600,
          fontFamily: "Light"),
    ));
  }

  mediumText(
      {dynamic text,
      double? size,
      Color? color,
      TextOverflow? textOverFlow,
      TextAlign? alignment}) {
    return Container(
        child: Text(
      text is Map ? text[LANGUAGE_TYPE] : text,
      style: TextStyle(
        fontSize: size,
        color: color,
        letterSpacing: .5,
        height: 1.4,
        fontWeight: FontWeight.w500,
        fontFamily: "Medium",
      ),
      textAlign: alignment ?? TextAlign.start,
      overflow: textOverFlow,
    ));
  }

  heavyText({dynamic text, double? size, Color? color}) {
    return Container(
        child: Text(
      text is Map ? text[LANGUAGE_TYPE] : text,
      style: TextStyle(fontSize: size, color: color, fontFamily: "Heavy"),
    ));
  }

  CustomTextWidget();
}
