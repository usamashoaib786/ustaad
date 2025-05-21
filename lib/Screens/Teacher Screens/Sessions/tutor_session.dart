import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';
import 'package:ustaad/custom%20widgets/seesion_cards.dart';

class TutorSessionScreen extends StatefulWidget {
  const TutorSessionScreen({super.key});

  @override
  State<TutorSessionScreen> createState() => _TutorSessionScreenState();
}

class _TutorSessionScreenState extends State<TutorSessionScreen> {
  bool showUpcoming = true;
  final upcomingSessions = [
    SessionCard(
      title: "Class at Mir Ahmed's House",
      duration: '2 hr Session',
      fee: 'Rs. 17000/mo',
      days: "Mon-Fri",
      time: '14h : 34m : 12s',
      color: AppTheme.primaryCOlor,
      isCompleted: false,
    ),
    SessionCard(
      title: "Class at Mir Ahmed's House",
      duration: '2 hr Session',
      fee: 'Rs. 17000/mo',
      days: "Mon-Fri",
      time: '14h : 34m : 12s',
      isCompleted: false,
    ),
    SessionCard(
      title: "Class at Mir Ahmed's House",
      duration: '2 hr Session',
      fee: 'Rs. 17000/mo',
      days: "Mon-Fri",
      time: '14h : 34m : 12s',
      isCompleted: false,
    ),
  ];

  final completedSessions = [
    SessionCard(
      title: "Class at Mir Ahmed's House",
      toDate: '3 December 2024',
      fee: 'Rs. 17000/mo',
      fromDate: "26 June 2024",
      time: '14h : 34m : 12s',
      isCompleted: true,
      rating: "4.5",
    ),
    SessionCard(
      title: "Class at Mir Ahmed's House",
      toDate: '3 December 2024',
      fee: 'Rs. 17000/mo',
      fromDate: "26 June 2024",
      time: '14h : 34m : 12s',
      isCompleted: true,
      rating: "4.5",
    ),SessionCard(
      title: "Class at Mir Ahmed's House",
      toDate: '3 December 2024',
      fee: 'Rs. 17000/mo',
      fromDate: "26 June 2024",
      time: '14h : 34m : 12s',
      isCompleted: true,
      rating: "4.5",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 40,
            width: 220,
            decoration: BoxDecoration(
                color: Color(0xffECEEF3),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showUpcoming = true;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 108,
                      decoration: BoxDecoration(
                          color: showUpcoming
                              ? AppTheme.primaryCOlor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: AppText.appText("Upcoming",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: showUpcoming
                                  ? AppTheme.white
                                  : AppTheme.black)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showUpcoming = false;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 108,
                      decoration: BoxDecoration(
                          color: !showUpcoming
                              ? AppTheme.primaryCOlor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: AppText.appText("Completed",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: !showUpcoming
                                  ? AppTheme.white
                                  : AppTheme.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemCount: showUpcoming
                  ? upcomingSessions.length
                  : completedSessions.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: showUpcoming == true? 0.7: 0.8,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return showUpcoming
                    ? upcomingSessions[index]
                    : completedSessions[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
