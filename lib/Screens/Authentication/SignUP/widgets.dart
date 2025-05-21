import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
  Widget passwordRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.appText("Must contain at least:",
            fontSize: 12, fontWeight: FontWeight.w400),
        requirement("At least 8 characters"),
        requirement("At least one Capital letter"),   
        requirement("At least one number or symbol"),
      ],
    );
  }

  Widget requirement(String text) {
    return Row(
      children: [
        Icon(Icons.circle, size: 8, color: AppTheme.grey),
        SizedBox(width: 8),
        AppText.appText(text,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: AppTheme.grey),
      ],
    );
  }

Widget stepIndicator(String label, int step,context, {required controller}) {
  bool isActive =  controller.index == step;

  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 3,
            width: ScreenSize(context).width * 0.27,
            color: isActive ? AppTheme.appColor : AppTheme.grey),
        SizedBox(height: 10),
        AppText.appText(label,
            fontSize: 14,
            textColor: AppTheme.lableText,
            fontWeight: FontWeight.w500),
      ],
    ),
  );
}
