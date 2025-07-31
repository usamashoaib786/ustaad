import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Drawer%20Screens/Cost%20Setting/cost_setting.dart';
import 'package:ustaad/Screens/Drawer%20Screens/earning_dashboard.dart';
import 'package:ustaad/Screens/Drawer%20Screens/location_screen.dart';
import 'package:ustaad/Screens/Drawer%20Screens/setting_screen.dart';

class SideMenuDrawer extends StatefulWidget {
  final VoidCallback? crossOnTap;
  final bool isTutor;

  const SideMenuDrawer({super.key, this.crossOnTap, required this.isTutor});

  @override
  State<SideMenuDrawer> createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Container(
          color: AppTheme.primaryCOlor, // Your teal/blue shade
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: widget.crossOnTap,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/arrow.png",
                    height: 24,
                  ),
                ),
              ),
              widget.isTutor == true
                  ? Expanded(
                      child: ListView(
                        children: [
                          menuItem(
                              onTap: () {},
                              "Check Parent Request",
                              "assets/images/checkParentRequest.png"),
                          menuItem(onTap: () {
                            push(context, TutorEarningScreen());
                          }, 'Earnings Dashboard',
                              "assets/images/earningDashBoard.png"),
                          menuItem(
                              onTap: () {},
                              'Documents/Verifications',
                              "assets/images/documentVerify.png"),
                          menuItem(onTap: () {
                            push(context, CostSetting());
                          }, 'Cost Settings', "assets/images/costSetting.png"),
                          menuItem(onTap: () {
                            push(context, SettingScreen());
                          }, 'Settings', "assets/images/setting.png"),
                          menuItem(
                              onTap: () {}, 'Help', "assets/images/help.png"),
                          menuItem(onTap: () {
                            push(context, LocationScreen());
                          }, 'Location Selection',
                              "assets/images/location.png"),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        children: [
                          menuItem(
                              onTap: () {},
                              "Check Your all Request",
                              "assets/images/checkParentRequest.png"),
                          menuItem(
                              onTap: () {},
                              'Payments',
                              "assets/images/earningDashBoard.png"),
                          menuItem(
                              onTap: () {},
                              'Documents/Verifications',
                              "assets/images/documentVerify.png"),
                          menuItem(onTap: () {
                            push(context, SettingScreen());
                          }, 'Settings', "assets/images/setting.png"),
                          menuItem(
                              onTap: () {}, 'Help', "assets/images/help.png"),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(String title, String img, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              img,
              height: 24,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.appText(
                    title,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.white,
                    fontSize: 16,
                  ),
                  SizedBox(height: 4),
                  AppText.appText(
                    'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum',
                    textColor: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
