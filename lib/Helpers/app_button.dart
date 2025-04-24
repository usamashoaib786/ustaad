import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';

class AppButton {
  static Widget appButton(String text,
      {double? height,
      required BuildContext context,
      double? width,
      Color? backgroundColor,
      EdgeInsetsGeometry? padding,
      TextAlign? textAlign,
      Color? textColor,
      double? fontSize,
      GestureTapCallback? onTap,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      Color? borderColor,
      TextBaseline? textBaseline,
      TextOverflow? overflow,
      var radius,
      double? letterSpacing,
      bool underLine = false,
      bool? border,
      bool? blurContainer}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        width: width ?? ScreenSize(context).width,
        height: height ?? 60,
        decoration: BoxDecoration(
            color: backgroundColor ?? AppTheme.appColor,
            borderRadius: BorderRadius.circular(radius ?? 10),
            border: border == false
                ? null
                : Border.all(
                    color: borderColor ?? AppTheme.appColor, width: 1)),
        child: AppText.appText(text,
            fontSize: fontSize ?? 20,
            textAlign: textAlign,
            fontWeight: fontWeight ?? FontWeight.w600,
            textColor: textColor ?? AppTheme.white,
            overflow: overflow,
            letterSpacing: letterSpacing,
            textBaseline: textBaseline,
            fontStyle: fontStyle,
            underLine: underLine),
      ),
    );
  }
}
