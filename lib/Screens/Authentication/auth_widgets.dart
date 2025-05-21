import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Authentication/login_screen.dart';
import 'package:ustaad/Screens/Authentication/SignUP/sign_up_screen.dart';

Widget customLableField({lable, controller, isPassword = false, hintText, fontSize,height,maxLines}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText.appText("$lable",
          fontSize: fontSize??14,
          fontWeight: FontWeight.w500,
          textColor: AppTheme.lableText),
      SizedBox(
        height: 10,
      ),
      CustomAppTextField(
        maxLines: maxLines,
        height: height,
        texthint: hintText ?? "$lable",
        controller: controller,
        isPasswordField: isPassword,
      )
    ],
  );
}

Widget phoneField({
  context,
  lable,
  controller,
}) {
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
      Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD4D8E2)),
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: PhoneFormField(
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: PhoneNumber(
              isoCode: "PK",
              nsn: '',
            ),
            onChanged: (phoneNumber) {},
            enabled: true,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          )),
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

Widget authHeader({context, bool? isSignInScreen}) {
  return Container(
    width: ScreenSize(context).width,
    height: isSignInScreen == true ? 275 : 241,
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
          const SizedBox(height: 30),
          if (isSignInScreen == true)
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
          if (isSignInScreen == false)
            AppText.appText("Sign Up",
                fontSize: 32,
                fontWeight: FontWeight.w600,
                textColor: AppTheme.white),
          const SizedBox(height: 15),
          Row(
            children: [
              AppText.appText(
                  isSignInScreen == true
                      ? "Don't have an account? "
                      : "Have an account? ",
                  textColor: Colors.white70),
              GestureDetector(
                onTap: () {
                  if (isSignInScreen == true) {
                    push(context, SignupScreen());
                  } else {
                    push(context, LogInScreen());
                  }
                },
                child: AppText.appText(
                    isSignInScreen == true ? "Sign Up" : "SignIN",
                    textColor: AppTheme.appColor),
              )
            ],
          )
        ],
      ),
    ),
  );
}
