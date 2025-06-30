import 'package:flutter/material.dart';
import 'package:ustaad/Screens/Authentication/SignUP/widgets.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parents%20OnBoard/add_payment.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parents%20OnBoard/child_profile.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/doc_verification.dart';

class ParentsOnboardScreen extends StatefulWidget {
  const ParentsOnboardScreen({super.key});

  @override
  State<ParentsOnboardScreen> createState() => _ParentsOnboardScreenState();
}

class _ParentsOnboardScreenState extends State<ParentsOnboardScreen>
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
                  stepIndicator("Profile", 0, context,
                      controller: _tabController),
                  stepIndicator("Payment", 1, context,
                      controller: _tabController),
                  stepIndicator("Verifications", 2, context,
                      controller: _tabController),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
               // so user can only go forward by button
                children: [
                  ParentChildProfile(
                    onTap: () {
                      if (_tabController.index < 2) {
                        setState(() {
                          _tabController.animateTo(_tabController.index + 1);
                        });
                      }
                    },
                  ),
                  ParentAddPayment(
                    onTap: () {
                      if (_tabController.index < 2) {
                        setState(() {
                          _tabController.animateTo(_tabController.index + 1);
                        });
                      }
                    },
                  ),
                  // TutorDocVerificationScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
