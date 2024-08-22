import 'package:exercise_app/Themes.dart';
import 'package:flutter/material.dart';

class CustomCheck {
  confirm(
      {double? size,
      double? iconSize,
      Color? backgroundColor,
      Color? borderColor,
      Color? iconColor}) {
    return Container(
      width: size ?? 20,
      height: size ?? 20,
      decoration: BoxDecoration(
          color: backgroundColor ?? PRIMARY,
          border: Border.all(color: borderColor ?? PRIMARY),
          borderRadius: BorderRadius.circular(100)),
      child: Icon(
        Icons.check,
        size: iconSize ?? 15,
        color: iconColor ?? BLACK,
      ),
    );
  }

  cancel(
      {double? size,
      double? iconSize,
      Color? backgroundColor,
      Color? borderColor,
      Color? iconColor}) {
    return Container(
      width: size ?? 20,
      height: size ?? 20,
      decoration: BoxDecoration(
          color: backgroundColor ?? LIGHT_GREY_TEXT.withOpacity(0.2),
          border: Border.all(
              color: borderColor ?? LIGHT_GREY_TEXT.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(100)),
      child: Icon(
        Icons.close,
        size: iconSize ?? 15,
        color: iconColor ?? BLACK,
      ),
    );
  }

  CustomCheck();
}
