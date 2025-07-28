import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/arrowBack.png")),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.appText("Settings",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                textColor: Color(0xff1E293B)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/user.png")),
                  ),
                ),
                Spacer(),
                AppButton.appButton("Edit",
                    context: context,
                    onTap: () {},
                    width: 59,
                    backgroundColor: AppTheme.black,
                    border: false),
                SizedBox(
                  width: 10,
                ),
                AppButton.appButton("Delete",
                    context: context,
                    onTap: () {},
                    width: 77,
                    backgroundColor: Color(0xffF43F5E),
                    border: false),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            customLableField(lable: "Name"),
            SizedBox(
              height: 20,
            ),
            customLableField(lable: "Email"),
            SizedBox(
              height: 20,
            ),
            customLableField(lable: "Phone Number"),
            SizedBox(
              height: 20,
            ),
            customLableField(lable: "Password"),
          ],
        ),
      ),
    );
  }
}
