import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/Screens/Authentication/confirm_pass.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();

  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
    clearPref();
    logger.init();
  }

  clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          authHeader(context: context, isPass: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customLableField(
                      lable: "Email", controller: _emailController),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      AppText.appText("Use your mobile phone number instead  ",
                          fontSize: 12,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w400),
                      GestureDetector(
                        onTap: () {
                          push(context, ConfirmPassScreen());
                        },
                        child: AppText.appText("Phone Number.",
                            fontSize: 12,
                            underLine: true,
                            textColor: AppTheme.appColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : AppButton.appButton("Continue", context: context,
                            onTap: () {
                            String email = _emailController.text.trim();
                            final emailPattern =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (email.isEmpty ||
                                !emailPattern.hasMatch(email)) {
                              Fluttertoast.showToast(
                                  msg: "Please enter a valid email address.");
                            } else {
                              forgotPass(context);
                            }
                          }, backgroundColor: AppTheme.primaryCOlor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void forgotPass(context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> params = {
      "email": _emailController.text,
    };
    try {
      Response response =
          await dio.post(path: AppUrls.forgotPass, data: params);
      var responseData = response.data;

      if (response.statusCode == 200) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${responseData["message"]}");
        setState(() {
          isLoading = false;
        });
        pushReplacement(
            context,
            ConfirmPassScreen(
              email: responseData["data"]["email"],
              userId: responseData["data"]["userId"],
            ));
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
