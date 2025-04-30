import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Screens/Authentication/SignUP/widgets.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/bank_selection.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/subject_screen.dart';

class TutorOnboardScreen extends StatefulWidget {
  const TutorOnboardScreen({super.key});

  @override
  State<TutorOnboardScreen> createState() => _TutorOnboardScreenState();
}

class _TutorOnboardScreenState extends State<TutorOnboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int currentStep = 0;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              stepIndicator("Subjects", 0, context, controller: _tabController),
              stepIndicator("Banks", 1, context, controller: _tabController),
              stepIndicator("Verifications", 2, context,
                  controller: _tabController),
            ],
          ),
        ),
           Expanded(
            child: TabBarView(
              controller: _tabController,
              physics:
                  NeverScrollableScrollPhysics(), // so user can only go forward by button
              children: [
               SubjectSelectionScreen(),
               BankSelectionScreen(),
               SubjectSelectionScreen(),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}
