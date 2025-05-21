import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Models/tutor_veirfy_provider.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/submission_screen.dart';

class TutorDocVerificationScreen extends StatefulWidget {
  const TutorDocVerificationScreen({
    super.key,
  });

  @override
  State<TutorDocVerificationScreen> createState() =>
      _TutorDocVerificationScreenState();
}

class _TutorDocVerificationScreenState
    extends State<TutorDocVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: 'Upload Your ',
              style: TextStyle(
                  fontSize: 44,
                  color: AppTheme.black,
                  fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: 'Documents',
                  style: TextStyle(
                      color: AppTheme.appColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 44),
                ),
                TextSpan(text: ' For Your '),
                TextSpan(
                  text: 'Verifications',
                  style: TextStyle(
                      color: AppTheme.appColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 44),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => fileProvider.pickFile(),
            child: Container(
              height: 183,
              width: ScreenSize(context).width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.borderCOlor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/docVerify.png',
                    height: 70,
                  ),
                  AppText.appText("Tap To Upload Documents",
                      fontSize: 16, fontWeight: FontWeight.w500),
                  SizedBox(
                    height: 10,
                  ),
                  AppText.appText("1.Resume ",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: AppTheme.lighttxtColor),
                  AppText.appText("2.ID Card/ Driving License/ Passport",
                      fontSize: 14, fontWeight: FontWeight.w400),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fileProvider.selectedFiles.length,
              itemBuilder: (context, index) {
                final file = fileProvider.selectedFiles[index].file;
                return Container(
                  height: 75,
                  width: ScreenSize(context).width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.borderCOlor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(file.name),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${(file.size / 1024).toStringAsFixed(1)} KB"),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => fileProvider.removeFile(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          AppButton.appButton("Proceed", context: context, onTap: () {
            pushReplacement(context, SubmissionCompleteScreen());
          },
              textColor: AppTheme.white,
              border: false,
              height: 52,
              backgroundColor: AppTheme.primaryCOlor)
        ],
      ),
    );
  }
}
