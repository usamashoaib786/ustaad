import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/tutor_on_board.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class OtpScreen extends StatefulWidget {
  final String? userId;
  final String? email;
  final String? phone;
  const OtpScreen({super.key, this.userId, this.email, this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController emailOtpController = TextEditingController();
  final TextEditingController phoneOtpController = TextEditingController();
  late Timer emailTimer;
  late Timer smsTimer;

  int emailSeconds = 120;
  int smsSeconds = 120;

  bool emailResendEnabled = false;
  bool smsResendEnabled = false;
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  @override
  void initState() {
    super.initState();
    startEmailTimer();
// startSmsTimer();
    dio = AppDio(context);
    logger.init();
    getOtp(context);
  }

  void startEmailTimer() {
    emailResendEnabled = false;
    emailSeconds = 120;
    emailTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (emailSeconds == 0) {
        emailResendEnabled = true;
        timer.cancel();
        setState(() {});
      } else {
        emailSeconds--;
        setState(() {});
      }
    });
  }

  void startSmsTimer() {
    smsResendEnabled = false;
    smsSeconds = 120;
    smsTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (smsSeconds == 0) {
        smsResendEnabled = true;
        timer.cancel();
        setState(() {});
      } else {
        smsSeconds--;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [header(), Expanded(child: otpScreen())],
      ),
    );
  }

  Widget header() {
    return Container(
      width: ScreenSize(context).width,
      height: 220,
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
            AppText.appText("OTP Verfication",
                fontSize: 32,
                fontWeight: FontWeight.w600,
                textColor: AppTheme.white),
          ],
        ),
      ),
    );
  }

  Widget otpScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            emailOtpFunction(),
            SizedBox(
              height: 40,
            ),
            phoneOtpFunction(),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton.appButton("Cancel", context: context, onTap: () {
                  Navigator.pop(context);
                },
                    width: ScreenSize(context).width * 0.4,
                    backgroundColor: AppTheme.button2ndCOlor,
                    textColor: AppTheme.black,
                    borderColor: Colors.transparent),
                AppButton.appButton(
                  "Verify",
                  context: context,
                  onTap: () {
                    if (emailOtpController.text.isEmpty ||
                        emailOtpController.text.length < 4) {
                      ToastHelper.displayErrorMotionToast(
                          context: context,
                          msg: "Please enter valid Email OTP");
                    }
                    //  else if (phoneOtpController.text.isEmpty ||
                    //     phoneOtpController.text.length < 4) {
                    //   ToastHelper.displayErrorMotionToast(
                    //       context: context, msg: "Please enter valid SMS OTP");
                    // }
                    else {
                      verifyOtp(context);
                    }
                  },
                  width: ScreenSize(context).width * 0.4,
                  borderColor: Colors.transparent,
                  backgroundColor: AppTheme.primaryCOlor,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget emailOtpFunction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/otpEmail.png"),
          height: 48,
        ),
        SizedBox(height: 20),
        AppText.appText(
          "Please check your email",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textColor: Colors.black87,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        AppText.appText(
          "We've sent a code to ${widget.email}",
          fontSize: 16,
          textColor: AppTheme.lighttxtColor,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        PinCodeTextField(
          appContext: context,
          length: 4,
          controller: emailOtpController,
          enableActiveFill: true,
          onChanged: (value) {},
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 70,
            activeFillColor: Color(0xffECEEF3),
            inactiveFillColor: Color(0xffECEEF3),
            selectedFillColor: Color(0xffECEEF3),
            activeColor: Colors.teal,
            selectedColor: Colors.teal,
            inactiveColor: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Didn't get a code? ", style: TextStyle(fontSize: 14)),
            emailResendEnabled
                ? GestureDetector(
                    onTap: () {
                      getOtp(context);
                      startEmailTimer(); // restart timer
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    "Resend in ${emailSeconds}s",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
          ],
        ),
      ],
    );
  }

  Widget phoneOtpFunction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/otpPhone.png"),
          height: 48,
        ),
        SizedBox(height: 20),
        AppText.appText(
          "Please check your SMS",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textColor: Colors.black87,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        AppText.appText(
          "We've sent a code to ${widget.phone}",
          fontSize: 16,
          textColor: AppTheme.lighttxtColor,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        PinCodeTextField(
          appContext: context,
          length: 4,
          controller: phoneOtpController,
          enableActiveFill: true,
          onChanged: (value) {},
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 70,
            activeFillColor: Color(0xffECEEF3),
            inactiveFillColor: Color(0xffECEEF3),
            selectedFillColor: Color(0xffECEEF3),
            activeColor: Colors.teal,
            selectedColor: Colors.teal,
            inactiveColor: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Didn't get a code? ",
              style: TextStyle(fontSize: 14),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Resend",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void getOtp(context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> params = {
      "userId": "${widget.userId}",
      "type": "email",
      "purpose": "email_verification",
    };
    try {
      Response response = await dio.post(path: AppUrls.otp, data: params);
      var responseData = response.data;

      if (response.statusCode == 200) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${responseData["message"]}");

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${responseData["message"]}");
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

  void verifyOtp(context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> params = {
      "userId": "${widget.userId}",
      "otp": emailOtpController.text,
      "type": "email",
      "purpose": "email_verification",
    };
    try {
      Response response = await dio.post(path: AppUrls.verifyOtp, data: params);
      var responseData = response.data;

      if (response.statusCode == 200) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${responseData["message"]}");

        setState(() {
          isLoading = false;
        });

        pushUntil(context, TutorOnboardScreen());
      } else {
        setState(() {
          isLoading = false;
        });
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${responseData["errors"][0]["message"]}");
      }
    } catch (e) {
      ToastHelper.displayErrorMotionToast(
          context: context, msg: "Something went wrong$e");
      setState(() {
        isLoading = false;
      });
    }
  }
}
