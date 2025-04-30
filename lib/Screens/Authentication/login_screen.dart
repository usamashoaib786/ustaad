import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/tutor_onBoard.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authHeader(context: context, isSignInScreen: true),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Column(
                children: [
                  customLableField(lable: "Email"),
                  const SizedBox(height: 20),
                  customLableField(lable: "Password", isPassword: true),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (_) {}),
                          AppText.appText("Remember me",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppTheme.grey),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: AppText.appText("Forgot Password?",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: AppTheme.appColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: AppButton.appButton("Sign In", context: context,
                        onTap: () {
                      pushReplacement(context, TutorOnboardScreen());
                    }, backgroundColor: AppTheme.primaryCOlor),
                  ),
                  loginDivider(),
                  const SizedBox(height: 30),
                  AppButton.appButton("Google",
                      context: context,
                      textColor: AppTheme.lableText,
                      borderColor: AppTheme.borderCOlor,
                      backgroundColor: AppTheme.white,
                      image: "assets/images/google.png"),
                  const SizedBox(height: 40),
                  loginFooter(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
