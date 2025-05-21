import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_about.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_educ.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_exp.dart';
import 'package:ustaad/custom widgets/ratings.dart';

class TutorProfileScreen extends StatefulWidget {
  const TutorProfileScreen({super.key});

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> tabTitles = [
      'About',
      'Education',
      'Experience',
      'Reviews'
    ];

    final List<Widget> tabContents = [
      TutorAboutSection(),
      TutorEducationScreen(),
      TutorExperience(),
      const Text(
          "Rated 4.0 from 11 students. Known for punctuality and concept clarity.",
          textAlign: TextAlign.center),
    ];

    return Scaffold(
      body: Padding(
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
                              child: Image.asset("assets/images/user.png"),
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
                            AppText.appText("Usama Shoaib",
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
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
    );
  }
}
