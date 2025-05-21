import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Chats/tutor_chat.dart';
import 'package:ustaad/Screens/Teacher%20Screens/HomeScreen/dash_board.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Profile/tutor_profile.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Sessions/tutor_session.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  final List<Widget> _screens = [
    const TutorDashBoardScreen(),
    const TutorChatScreen(),
    const TutorSessionScreen(),
    const TutorProfileScreen(),
  ];
  int _currentIndex = 0;
  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 75,

          animationCurve: Curves.easeOut,
          animationDuration: Duration(milliseconds: 400),
          color: AppTheme.appColor, // Semi-transparent background
          backgroundColor: Colors.transparent,
          index: _currentIndex,
          items: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
                "assets/images/dashBoard_icon.png",
                color: AppTheme.white,
                height: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Image.asset(
                "assets/images/chatss.png",
              color: AppTheme.white,
                height: 30,
              ),
            ),
            Image.asset(
              "assets/images/clock.png",
              color: AppTheme.white,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Image.asset(
                "assets/images/profile.png",
                color: AppTheme.white,
                height: 30,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: _screens[_currentIndex],
      ),
    );
  }
}
