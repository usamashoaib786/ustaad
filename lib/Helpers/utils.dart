import 'package:flutter/cupertino.dart';

// Fluttertoast.showToast(msg: text) {
//   var snackBar = SnackBar(content: Text(text));
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

push(context, screen) {
  Navigator.push(context, CupertinoPageRoute(builder: (_) => screen));
}

pushReplacement(context, screen) {
  Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (_) => screen));
}

pushUntil(context, screen) {
  Navigator.pushAndRemoveUntil(
      context, CupertinoPageRoute(builder: (_) => screen), (route) => false);
}

// navigateFunction({context})async{
//  SharedPreferences pref = await SharedPreferences.getInstance();
//         pref.clear();
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const SignInScreen(),
//             ),
//             (route) => false);
// }
