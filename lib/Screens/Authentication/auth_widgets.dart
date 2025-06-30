import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Authentication/login_screen.dart';
import 'package:ustaad/Screens/Authentication/SignUP/sign_up_screen.dart';

Widget customLableField(
    {lable,
    controller,
    isPassword = false,
    hintText,
    fontSize,
    height,
    maxLines,
    width}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText.appText("$lable",
          fontSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
          textColor: AppTheme.lableText),
      SizedBox(
        height: 10,
      ),
      CustomAppTextField(
        maxLines: maxLines,
        height: height,
        width: width,
        texthint: hintText ?? "$lable",
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

Widget authHeader({context, bool? isSignInScreen, bool? isPass}) {
  return Container(
    width: ScreenSize(context).width,
    height: isPass == true
        ? 221
        : isSignInScreen == true
            ? 275
            : 241,
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
                    fontSize: 26,
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
          if (isPass == true)
            AppText.appText("Forgot Password",
                fontSize: 32,
                fontWeight: FontWeight.w600,
                textColor: AppTheme.white),
          const SizedBox(height: 15),
          if (isPass != true)
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

class CardNumberField extends StatefulWidget {
  final TextEditingController controller;
  const CardNumberField({super.key, required this.controller});

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  String get rawCardNumber => widget.controller.text.replaceAll(' ', '');

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      final text = widget.controller.text;
      final formatted = _formatCardNumber(text);

      if (text != formatted) {
        final cursorPosition = widget.controller.selection.baseOffset;
        widget.controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(
              offset: _adjustCursorPosition(cursorPosition, text, formatted)),
        );
      }
    });
  }

  String _formatCardNumber(String input) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if ((i + 1) % 4 == 0 && i + 1 != digits.length) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }

  int _adjustCursorPosition(int oldPosition, String oldText, String newText) {
    int diff = newText.length - oldText.length;
    return (oldPosition + diff).clamp(0, newText.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD4D8E2)),
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        maxLines: 1,
        controller: widget.controller,
        keyboardType: TextInputType.name,
        cursorColor: AppTheme.appColor,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(8),
          hintText: "1234 1234 1234 1234",
          hintStyle: TextStyle(
            color: AppTheme.hintColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
