import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/pref_keys.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Providers/parent_profile_provider.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Profile/child_detail.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Profile/child_teacher_notes.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Profile/parents_reviews.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/custom widgets/ratings.dart';

class ParentProfileScreen extends StatefulWidget {
  const ParentProfileScreen({super.key});

  @override
  State<ParentProfileScreen> createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  int selectedTab = 0;
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();

  String? name = "";
  String? userPic = "";
  String? userId = "";
  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
    logger.init();
    getUserData();
    Future.microtask(() {
      Provider.of<ParentProfileProvider>(context, listen: false)
          .fetchChildren();
    });
  }

  getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString(PrefKey.userName);
      userPic = pref.getString(PrefKey.userPic);
      userId = pref.getString(PrefKey.id);
      if (kDebugMode) {
        print("UserId$userId");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabTitles = ['Children', 'Teacher Notes', 'Reviews'];
    final provider = Provider.of<ParentProfileProvider>(context);

    final List<Widget> tabContents = [
      ChildDetails(userId: userId!),
      ChildTeacherNotes(),
      ParentsReviews()
    ];

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Background.png", // replace with your image path
            fit: BoxFit.fill,
            width: ScreenSize(context).width,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/ustaad.png")),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(
                            children: [
                              Container(
                                height: 130,
                                width: 130,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffF2FBF8),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2, color: AppTheme.appColor),
                                  ),
                                  child: userPic == ""
                                      ? Image.asset("assets/images/profile.png")
                                      : Image.asset(userPic!),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.appText(name!,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppTheme.black),
                                AppText.appText(
                                    "${provider.children.length} children profiles",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppTheme.grey),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const RatingStars(rating: 4.5),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      AppText.appText("4.0",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          textColor: const Color(0xff101219)),
                                      const SizedBox(width: 5),
                                      AppText.appText("11 Reviews",
                                          underLine: true,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          textColor: const Color(0xff4D5874)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: List.generate(tabTitles.length, (index) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTab = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      color: selectedTab == index
                                          ? Colors.teal
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      tabTitles[index],
                                      style: TextStyle(
                                        color: selectedTab == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 20),
                        tabContents[selectedTab]
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
