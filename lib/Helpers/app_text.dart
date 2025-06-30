import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_theme.dart';

class AppText {
  static Widget appText(String text,
      {TextAlign? textAlign,
      Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      bool? softWrap,
      TextBaseline? textBaseline,
      TextOverflow? overflow,
      int? maxlines,
      double? letterSpacing,
      bool underLine = false,
      Color? decorationColor,
      bool fontFamily = false}) {
    return Text(
      softWrap: softWrap,
      text,
      textAlign: textAlign,
      maxLines: maxlines,
      style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: 'Montserrat',
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          overflow: overflow,
          fontStyle: fontStyle,
          textBaseline: textBaseline,
          decorationColor: decorationColor ?? AppTheme.appColor,
          decoration: underLine == false
              ? TextDecoration.none
              : TextDecoration.underline),
    );
  }
}
