import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/pref_keys.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Authentication/SignUP/country_picker.dart';
import 'package:ustaad/Screens/Authentication/SignUP/widgets.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/tutor_on_board.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  late TabController _tabController;
  final TextEditingController emailOtpController = TextEditingController();
  final TextEditingController phoneOtpController = TextEditingController();

  late Timer emailTimer;
  late Timer smsTimer;

  int emailSeconds = 120;
  int smsSeconds = 120;

  bool emailResendEnabled = false;
  bool smsResendEnabled = false;
  String selectedRole = "Tutor";
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  String _selectedCountry = "Pakistan";
  var finalData;
  @override
  void initState() {
    super.initState();

    startEmailTimer();
// startSmsTimer();
    _passwordController.addListener(() {
      setState(() {}); // ✅ rebuild UI when password text changes
    });
    _tabController = TabController(length: 3, vsync: this);
    dio = AppDio(context);
    logger.init();
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
        children: [
          authHeader(context: context, isSignInScreen: false),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                stepIndicator("User Details", 0, context,
                    controller: _tabController),
                stepIndicator("Add Details", 1, context,
                    controller: _tabController),
                stepIndicator("OTP", 2, context, controller: _tabController),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics:
                  NeverScrollableScrollPhysics(), // so user can only go forward by button
              children: [
                _userDetailsForm(),
                _additionDetails(),
                otpScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _userDetailsForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          AppText.appText("Sign Up As:",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textColor: AppTheme.lighttxtColor),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoleOption("Tutor"),
              SizedBox(width: 20),
              _buildRoleOption("Parent"),
            ],
          ),
          SizedBox(height: 20),
          customLableField(lable: "Full Name", controller: _nameController),
          SizedBox(height: 20),
          customLableField(lable: "Email", controller: _emailController),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.appText("Phone Number",
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
                    defaultCountry: "PK",
                    autovalidateMode: AutovalidateMode.disabled,
                    initialValue: PhoneNumber(
                      isoCode: "PK",
                      nsn: '',
                    ),
                    onChanged: (phoneNumber) {
                      phoneController.text =
                          "${phoneNumber?.dialCode}${phoneNumber?.nsn}";
                    },
                    enabled: true,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  )),
            ],
          ),
          SizedBox(height: 20),
          customLableField(
              lable: "Password",
              isPassword: true,
              controller: _passwordController),
          SizedBox(height: 20),
          PasswordStrengthIndicator(
            password: _passwordController.text,
            width: ScreenSize(context).width,
            thickness: 5,
            backgroundColor: Colors.grey,
            radius: 8,
            colors: StrengthColors(
              weak: Colors.orange,
              medium: Colors.yellow,
              strong: Colors.green,
            ),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            callback: (double strength) {},
            strengthBuilder: (String password) {
              return password.length / 10;
            },
            style: StrengthBarStyle.dashed,
          ),
          SizedBox(height: 10),
          passwordRequirements(),
          SizedBox(height: 20),
          AppButton.appButton("Next", onTap: () {
            String name = _nameController.text.trim();
            String email = _emailController.text.trim();
            String phone = phoneController.text.trim();
            String password = _passwordController.text.trim();

// Regular expressions
            final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            final passwordRegex = RegExp(
                r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$');

            if (name.isEmpty) {
              Fluttertoast.showToast(msg: "Please enter your full name.");
            } else if (email.isEmpty || !emailPattern.hasMatch(email)) {
              Fluttertoast.showToast(
                  msg: "Please enter a valid email address.");
            } else if (phone.isEmpty || phone.length < 10) {
              Fluttertoast.showToast(msg: "Please enter a valid phone number.");
            } else if (password.isEmpty || password.length < 6) {
              Fluttertoast.showToast(
                  msg: "Password must be at least 6 characters long.");
            } else if (!passwordRegex.hasMatch(password)) {
              Fluttertoast.showToast(
                  msg:
                      "Password must include at least one uppercase letter, one number, and one special character.");
            } else {
              if (_tabController.index < 2) {
                setState(() {
                  _tabController.animateTo(_tabController.index + 1);
                });
              }
            }
          }, context: context),
        ],
      ),
    );
  }

////////////////////////// ADDITIONAL DETAILS ////////////////////////
  Widget _additionDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            customLableField(lable: "CNIC", controller: _cnicController),
            const SizedBox(height: 20),
            customLableField(lable: "Address", controller: _addressController),
            const SizedBox(height: 20),
            customLableField(lable: "City", controller: _cityController),
            const SizedBox(height: 20),
            customLableField(lable: "State", controller: _stateController),
            const SizedBox(height: 20),
            CountryPickerField(
              onCountrySelected: (country) {
                _selectedCountry = country;
              },
            ),
            const SizedBox(height: 20),
            isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : AppButton.appButton("Next", onTap: () {
                    if (_cnicController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter CNIC");
                    } else if (_cnicController.text.trim().length != 13 ||
                        !RegExp(r'^\d{13}$')
                            .hasMatch(_cnicController.text.trim())) {
                      Fluttertoast.showToast(
                          msg: "CNIC must be exactly 13 digits.");
                    } else if (_addressController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter Address");
                    } else if (_cityController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter City");
                    } else if (_stateController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Please enter State");
                    } else {
                      signUp(context);
                    }
                  }, context: context),
          ],
        ),
      ),
    );
  }

//////////////////////////////////
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
          "We've sent a code to ${_emailController.text}",
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
          "We've sent a code to ${phoneController.text}",
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

///////////////////////////
  Widget _buildRoleOption(String role) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        height: 36,
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppTheme.appColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Radio<String>(
              value: role,
              groupValue: selectedRole,
              activeColor: AppTheme.appColor,
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
            AppText.appText(role, fontSize: 14, fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////   Api's Integeregtion ////////////////////////////////////

  void signUp(context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> params = {
      "role": selectedRole.toUpperCase(),
      "fullName": _nameController.text,
      "password": _passwordController.text,
      "cnic": _cnicController.text,
      "address": _addressController.text,
      "city": _cityController.text,
      "state": _stateController.text,
      "country": _selectedCountry,
      "email": _emailController.text.trim().replaceAll(' ', ''),
      "phone": phoneController.text
    };
    try {
      Response response = await dio.post(path: AppUrls.signUp, data: params);
      var responseData = response.data;

      if (response.statusCode == 200) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${responseData["message"]}");

        setState(() async {
          isLoading = false;
          finalData = responseData["data"];
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
          getOtp(context);
        });

        if (_tabController.index < 2) {
          setState(() {
            _tabController.animateTo(_tabController.index + 1);
          });
        }

        getOtp(context);
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

  void getOtp(context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> params = {
      "userId": "${finalData["id"]}",
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
      "userId": "${finalData["id"]}",
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
