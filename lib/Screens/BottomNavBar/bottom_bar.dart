import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Chat%20Screen/parent_chat.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Dashboard/dashboard.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Profile/parent_profile.dart';
import 'package:ustaad/Screens/Parents%20Screens/Parent%20Sessions/parent_session.dart';
import 'package:ustaad/Screens/Chats/tutor_chat.dart';
import 'package:ustaad/Screens/Teacher%20Screens/HomeScreen/dash_board.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_profile.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Sessions/tutor_session.dart';

class BottomNavView extends StatefulWidget {
  final bool tutor;
  const BottomNavView({super.key, required this.tutor});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _currentIndex = 0;

  List<Widget> get _screens => widget.tutor
      ? const [
          TutorDashBoardScreen(),
          TutorChatScreen(),
          TutorSessionScreen(),
          TutorProfileScreen(),
        ]
      : const [
          ParentsDashBoardScreen(),
          ParentChatScreen(),
          ParentSessionScreen(),
          ParentProfileScreen(),
        ];

  final List<String> _titles = ["Home", "Chat", "Sessions", "Profile"];
  final List<String> _icons = [
    "assets/images/dashBoard_icon.png",
    "assets/images/chatss.png",
    "assets/images/clock.png",
    "assets/images/profile.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppTheme.appColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            final isSelected = _currentIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _currentIndex = index);
                },
                child: SizedBox(
                  height: 80,
                  width: ScreenSize(context).width / 4,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (isSelected)
                        Positioned(
                          top: -15,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryCOlor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppTheme.appColor, width: 1),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    _icons[index],
                                    height: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _titles[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      else
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                _icons[index],
                                height: 24,
                                color: Colors.black87,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _titles[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
