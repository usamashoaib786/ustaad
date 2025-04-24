import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';

Widget customLableField({lable, controller, isPassword = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText.appText("$lable",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textColor: AppTheme.lableText),
      SizedBox(
        height: 10,
      ),
      CustomAppTextField(
        texthint: "$lable",
        controller: controller,
        isPasswordField: isPassword,
      )
    ],
  );
}

Widget loginFooter() {
  return Center(
    child: Text.rich(
      TextSpan(
        text: "By signing up, you agree to the ",
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppTheme.lableText),
        children: [
          TextSpan(
            text: "Terms of Service ",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppTheme.lableText),
          ),
          TextSpan(
            text: "and ",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppTheme.lableText),
          ),
          TextSpan(
            text: "Data Processing Agreement",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppTheme.lableText),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget loginDivider() {
  return Row(
    children: [
      const Expanded(
          child: Divider(
        color: Color(0xffEDF1F3),
      )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: AppText.appText("Or login with",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: AppTheme.grey),
      ),
      const Expanded(
          child: Divider(
        color: Color(0xffEDF1F3),
      )),
    ],
  );
}

Widget authHeader({context}) {
  return Container(
    width: ScreenSize(context).width,
    height: 275,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/images/Head.png",
            ),
            fit: BoxFit.fill)),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Image.asset('assets/images/logo1.png', height: 50), 
          const SizedBox(height: 40),
          Text.rich(
            TextSpan(
              text: 'Sign in to your ',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: 'Ustaad',
                  style: TextStyle(
                      color: AppTheme.appColor, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' Account'),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              AppText.appText("Don't have an account? ",
                  textColor: Colors.white70),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: AppTheme.appColor),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
