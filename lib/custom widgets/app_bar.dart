import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String taskSummary;
  final String profileImage;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final bool? backArrow;

  const CustomAppBar({
    super.key,
    this.username = "Usama Shoaib",
    this.taskSummary = "6 tasks for Today",
    this.profileImage = "",
    this.onMenuTap,
    this.onNotificationTap,
    this.backArrow,
  });

  @override
  Size get preferredSize => Size.fromHeight(
      backArrow == true ? 120 : 100); // Height of your custom AppBar

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            backArrow == true
                ? InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/images/arrowBack.png",
                        height: 28,
                      )),
                )
                : Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/ustaad.png"),
                  ),
            if (backArrow == true) const SizedBox(height: 20),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1, color: AppTheme.primaryCOlor),
                        image: profileImage.isNotEmpty
                            ? DecorationImage(
                                image: AssetImage(profileImage),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: profileImage.isEmpty
                          ? const Icon(Icons.person,
                              size: 24, color: Colors.grey)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.appText(username,
                            fontSize: 16, fontWeight: FontWeight.w600),
                        AppText.appText(taskSummary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textColor: AppTheme.grey),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onNotificationTap,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1, color: AppTheme.primaryCOlor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset("assets/images/notify.png"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: onMenuTap,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryCOlor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset("assets/images/menu.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
