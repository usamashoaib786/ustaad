import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/chart.dart';
import 'package:ustaad/Helpers/get_location.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Providers/get_tutors_provider.dart';
import 'package:ustaad/Screens/Drawer/tutor_drawer.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_profile.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';

class ParentsDashBoardScreen extends StatefulWidget {
  const ParentsDashBoardScreen({super.key});

  @override
  State<ParentsDashBoardScreen> createState() => _ParentsDashBoardScreenState();
}

class _ParentsDashBoardScreenState extends State<ParentsDashBoardScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List subList = [
    "English",
    "Physics",
    "Chemistry",
    "Biology",
    "Social Studies",
  ];
  List imgSubList = [
    "assets/images/book.png",
    "assets/images/physics.png",
    "assets/images/chem.png",
    "assets/images/bio.png",
    "assets/images/social.png",
  ];
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final position = await getCurrentLocation();
      if (position != null) {
        await Provider.of<GetTutorsProvider>(context, listen: false)
            .fetchNearbyTutors(position.latitude, position.longitude);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SideMenuDrawer(
        crossOnTap: () {
          _scaffoldKey.currentState?.closeEndDrawer();
        },
        isTutor: false,
      ),
      appBar: CustomAppBar(
        onMenuTap: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  parentHomeSearchField(context, _searchController),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      text: 'Next Paymet of ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff15112E),
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Rs. 25000',
                          style: TextStyle(
                            color: AppTheme.appColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            decorationColor: AppTheme.appColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' due on 01-Mar-25 '),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.appText("Featured Subject Categories",
                          fontSize: 16, fontWeight: FontWeight.w600),
                      AppText.appText("View All",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          textColor: Color(0xffA4B0BE)),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              width: ScreenSize(context).width,
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      if (index == 0)
                        SizedBox(
                          width: 20,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SizedBox(
                          height: 67,
                          child: Column(
                            children: [
                              Image.asset(
                                "${imgSubList[index]}",
                                height: 40,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AppText.appText("${subList[index]}",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  textColor: Color(0xffA4B0BE)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppText.appText("Trending Tutors in Your Area",
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Consumer<GetTutorsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.tutors.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("No tutors found nearby."),
                  );
                }

                return SizedBox(
                  width: ScreenSize(context).width,
                  height: 135,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.tutors.length,
                    itemBuilder: (context, index) {
                      final tutor = provider.tutors[index];

                      return Row(
                        children: [
                          if (index == 0)
                            SizedBox(
                              width: 20,
                            ),
                          InkWell(
                            onTap: () {
                              push(
                                  context,
                                  TutorProfileScreen(
                                    isParentSide: true,
                                    name: tutor.name,
                                    tutorId: tutor.tutorId,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Container(
                                height: 135,
                                width: 142,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/images/man.png"),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 12,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          AppText.appText("${tutor.rating}",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              textColor: AppTheme.black),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          height: 48,
                                          width: 142,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AppText.appText(tutor.name,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    textColor: Colors.white),
                                                AppText.appText(tutor.subject,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    textColor: Colors.white
                                                        .withOpacity(0.8)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  AppText.appText("Monthly Spending",
                      fontSize: 16, fontWeight: FontWeight.w600),
                  SizedBox(
                    width: 10,
                  ),
                  AppText.appText("(12 March - 19 March)",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textColor: Color(0xffB0B0B0)),
                ],
              ),
            ),
            EarningsBarChart(),
          ],
        ),
      ),
    );
  }
}
