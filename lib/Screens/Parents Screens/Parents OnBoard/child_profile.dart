import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class ParentChildProfile extends StatefulWidget {
  final Function()? onTap;
  const ParentChildProfile({super.key, this.onTap});

  @override
  State<ParentChildProfile> createState() => _ParentChildProfileState();
}

class _ParentChildProfileState extends State<ParentChildProfile> {
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'To Continue.. Just ',
                style: TextStyle(
                    fontSize: 44,
                    color: AppTheme.black,
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: 'Add',
                    style: TextStyle(
                        color: AppTheme.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 44),
                  ),
                  TextSpan(text: ' Your '),
                  TextSpan(
                    text: "Child's Profile",
                    style: TextStyle(
                        color: AppTheme.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 44),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AppText.appText(
                  'Child 1:',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                AppText.appText(
                  ' Add details of your child',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 100,
              width: ScreenSize(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("assets/images/user.png"),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton.appButton("Upload New",
                          context: context,
                          width: 215,
                          onTap: () {},
                          backgroundColor: Color(0xffF1FCF9),
                          border: false,
                          textColor: AppTheme.appColor),
                      AppButton.appButton("Delete Image",
                          context: context,
                          width: 215,
                          onTap: () {},
                          backgroundColor: Color(0xffFEECEC),
                          border: false,
                          textColor: Colors.red)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            customLableField(lable: "Child Full Name"),
            SizedBox(height: 20),
            AppText.appText("Gender",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppTheme.lableText),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Male
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = 'Male';
                    });
                  },
                  child: Container(
                    height: 44,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedGender == 'Male'
                            ? AppTheme.appColor
                            : Color(0xffD4D8E2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: selectedGender,
                          activeColor: AppTheme.appColor,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                        Text('Male'),
                      ],
                    ),
                  ),
                ),

                // Female
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = 'Female';
                    });
                  },
                  child: Container(
                    height: 44,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedGender == 'Female'
                            ? AppTheme.appColor
                            : Color(0xffD4D8E2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: 'Female',
                          groupValue: selectedGender,
                          activeColor: AppTheme.appColor,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customLableField(
                    lable: "Grade", width: ScreenSize(context).width * 0.40),
                SizedBox(height: 20),
                customLableField(
                    lable: "Age", width: ScreenSize(context).width * 0.40),
              ],
            ),
            SizedBox(height: 20),
            customLableField(lable: "School Name"),
            SizedBox(height: 20),
            AppButton.appButton("Add Another Child",
                context: context,
                onTap: widget.onTap,
                textColor: AppTheme.black,
                border: true,
                height: 44,
                borderColor: const Color(0xffD4D8E2),
                backgroundColor: Colors.transparent),
            SizedBox(height: 20),
            AppButton.appButton("Proceed",
                context: context,
                onTap: widget.onTap,
                textColor: AppTheme.white,
                border: false,
                height: 44,
                backgroundColor: AppTheme.primaryCOlor)
          ],
        ),
      ),
    );
  }
}
