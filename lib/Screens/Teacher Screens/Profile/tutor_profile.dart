import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/pref_keys.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Authentication/login_screen.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_about.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_educ.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_exp.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_reviews.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';
import 'package:ustaad/custom widgets/ratings.dart';

class TutorProfileScreen extends StatefulWidget {
  final bool isParentSide;
  final String? name;
  final String? tutorId;

  const TutorProfileScreen(
      {super.key, required this.isParentSide, this.name, this.tutorId});

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  int selectedTab = 0;
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  Map<String, dynamic>? tutorData;

  String? name = "";
  String? userPic = "";
  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
    logger.init();
    if (widget.isParentSide == false) {
      getUserData();
    }
    if (widget.isParentSide == true) {
      print("object${widget.tutorId}");
      getTutorProfileFromParentSide(context: context, tutorId: widget.tutorId);
    }
    // getProfile(context);
  }

  getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString(PrefKey.userName);
      userPic = pref.getString(PrefKey.userPic);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabTitles = [
      'About',
      'Education',
      'Experience',
      'Reviews'
    ];

    final List<Widget> tabContents = [
      TutorAboutSection(
        isParentSide: widget.isParentSide,
        data: tutorData,
      ),
      TutorEducationScreen(
        isParentSide: widget.isParentSide,
        data: tutorData,
      ),
      TutorExperience(
        isParentSide: widget.isParentSide,
        data: tutorData,
      ),
      TutorReviews(
        isParentSide: widget.isParentSide,
        data: tutorData,
      )
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
                                AppText.appText(
                                    widget.isParentSide == true
                                        ? "${widget.name}"
                                        : name!,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppTheme.black),
                                AppText.appText("6 years Experience",
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
                        if(widget.isParentSide == false)
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

  void getProfile(context) async {
    setState(() {
      isLoading = true;
    });

    try {
      Response response = await dio.get(
        path: AppUrls.getTutorProfile,
      );
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

  void getTutorProfileFromParentSide({context, tutorId}) async {
    setState(() {
      isLoading = true;
    });

    try {
      Response response = await dio.get(
        path: "${AppUrls.getTutorProfileFromParentSide}$tutorId",
      );
      var responseData = response.data;
      if (response.statusCode == 200) {
        setState(() {
          tutorData = responseData["data"]; // 👈 Save the tutor data
          isLoading = false;
        });

        ToastHelper.displaySuccessMotionToast(
          context: context,
          msg: "${responseData["message"]}",
        );
      } else if (response.statusCode == 401 &&
          responseData["errors"][0]["message"] == "TokenExpired") {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${responseData["errors"][0]["message"]}");

        pushUntil(context, LogInScreen());
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
