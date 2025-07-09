import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/pref_keys.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/Screens/Authentication/forgot_pass.dart';
import 'package:ustaad/Screens/Authentication/otp.dart';
import 'package:ustaad/Screens/BottomNavBar/bottom_bar.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parents%20OnBoard/parents_onboard.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/tutor_on_board.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  var finalData;
  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
    logger.init();
  }

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
                  customLableField(
                      lable: "Email", controller: _emailController),
                  const SizedBox(height: 20),
                  customLableField(
                      lable: "Password",
                      isPassword: true,
                      controller: _passwordController),
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
                        onTap: () {
                          push(context, ForgotPassScreen());
                        },
                        child: AppText.appText("Forgot Password?",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: AppTheme.appColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : AppButton.appButton("Sign In", context: context,
                            onTap: () {
                            // pushReplacement(context, TutorOnboardScreen());
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();

                            final emailPattern =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (email.isEmpty ||
                                !emailPattern.hasMatch(email)) {
                              Fluttertoast.showToast(
                                  msg: "Please enter a valid email address.");
                            } else if (password.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please enter  Password");
                            } else {
                              signIn(context);
                            }
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

  void signIn(context) async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> params = {
      "email": _emailController.text.trim().replaceAll(' ', ''),
      "password": _passwordController.text,
    };
    try {
      Response response = await dio.post(path: AppUrls.logIn, data: params);
      var responseData = response.data;

      if (response.statusCode == 200) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${responseData["message"]}");

        setState(() {
          isLoading = false;
        });

        var finalData = responseData["data"];
        var token = finalData["token"];
        var userId = finalData["id"];
        var userRole = finalData["role"];
        var userName = finalData["fullName"];
        var profilePic = finalData["profilePic"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(PrefKey.authorization, token ?? '');
        prefs.setString(PrefKey.id, userId);
        prefs.setString(PrefKey.userRole, userRole);
        prefs.setString(PrefKey.userName, userName);
        prefs.setString(PrefKey.userPic, profilePic ?? '');

        if (finalData["isEmailVerified"] == false) {
          push(
              context,
              OtpScreen(
                userId: "${finalData["id"]}",
                email: _emailController.text,
                phone: "${finalData["phone"]}",
              ));
        } else if (finalData["isOnBoard"] == "required" &&
            finalData["role"] == "TUTOR") {
          push(context, TutorOnboardScreen());
        } else if (finalData["isOnBoard"] == "required" &&
            finalData["role"] == "PARENT") {
          push(context, ParentsOnboardScreen());
        } else if (finalData["role"] == "TUTOR") {
          push(
              context,
              BottomNavView(
                tutor: true,
              ));
        } else if (finalData["role"] == "PARENT") {
          push(
              context,
              BottomNavView(
                tutor: false,
              ));
        }
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => const OnBoardScreen()),
        //   (route) => false,
        // );
      } else {
        setState(() {
          isLoading = false;
        });
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${responseData["errors"][0]["message"]}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong: $e");
      }
      ToastHelper.displayErrorMotionToast(
          context: context, msg: "Something went wrong$e");
      setState(() {
        isLoading = false;
      });
    }
  }
}
