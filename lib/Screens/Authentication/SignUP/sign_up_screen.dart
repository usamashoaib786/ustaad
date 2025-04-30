import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Authentication/SignUP/country_picker.dart';
import 'package:ustaad/Screens/Authentication/SignUP/widgets.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  late TabController _tabController;
  int currentStep = 0;
  String selectedRole = "Tutor";
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {}); // ✅ rebuild UI when password text changes
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    otpController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    otpController.dispose();
    super.dispose();
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
          phoneField(
              lable: "Phone Number",
              context: context,
              controller: _phoneController),
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
            if (_tabController.index < 2) {
              setState(() {
                _tabController.animateTo(_tabController.index + 1);
              });
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
      child: Column(
        children: [
          customLableField(
            lable: "CNIC",
          ),
          SizedBox(
            height: 20,
          ),
          customLableField(
            lable: "Address",
          ),
          SizedBox(
            height: 20,
          ),
          customLableField(
            lable: "City",
          ),
          SizedBox(
            height: 20,
          ),
          customLableField(
            lable: "State",
          ),
          SizedBox(
            height: 20,
          ),
          CountryPickerField(),
          SizedBox(
            height: 20,
          ),
          AppButton.appButton("Next", onTap: () {
            if (_tabController.index < 2) {
              setState(() {
                _tabController.animateTo(_tabController.index + 1);
              });
            }
          }, context: context),
        ],
      ),
    );
  }

//////////////////////////////////
  Widget otpScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customOtpFunction(isEmail: true),
            SizedBox(
              height: 40,
            ),
            customOtpFunction(isEmail: false),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton.appButton("Cancel",
                    context: context,
                    onTap: () {},
                    width: ScreenSize(context).width * 0.4,
                    backgroundColor: AppTheme.button2ndCOlor,
                    textColor: AppTheme.black,
                    borderColor: Colors.transparent),
                AppButton.appButton(
                  "Verify",
                  context: context,
                  onTap: () {},
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

  Widget customOtpFunction({isEmail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(isEmail == true
              ? "assets/images/otpEmail.png"
              : "assets/images/otpPhone.png"),
          height: 48,
        ),
        SizedBox(height: 20),
        AppText.appText(
          isEmail == true ? "Please check your email" : "Please check your SMS",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textColor: Colors.black87,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        AppText.appText(
          isEmail == true
              ? "We've sent a code to abc@gmail.com"
              : "We've sent a code to +923134598073",
          fontSize: 16,
          textColor: AppTheme.lighttxtColor,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        PinCodeTextField(
          appContext: context,
          length: 4,
          controller: otpController,
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
}
