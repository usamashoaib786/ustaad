import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Providers/tutor_veirfy_provider.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/data_model.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/submission_screen.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class TutorDocVerificationScreen extends StatefulWidget {
  final TutorOnboardData onboardData;

  const TutorDocVerificationScreen({
    super.key,
    required this.onboardData,
  });

  @override
  State<TutorDocVerificationScreen> createState() =>
      _TutorDocVerificationScreenState();
}

class _TutorDocVerificationScreenState
    extends State<TutorDocVerificationScreen> {
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();
  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
    logger.init();
  }

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
                return Card(
                  margin: EdgeInsets.only(bottom: 20),
                  color: AppTheme.white,
                  child: Container(
                    height: 75,
                    width: ScreenSize(context).width,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            SizedBox(
                                width: ScreenSize(context).width * 0.6,
                                height: 20,
                                child: AppText.appText(file.name,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis)),
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
                  ),
                );
              },
            ),
          ),
          isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : AppButton.appButton(
                  "Proceed",
                  context: context,
                  onTap: () {
                    if (fileProvider.selectedFiles.length >= 3) {
                      widget.onboardData.resumeFile =
                          File(fileProvider.selectedFiles[0].file.path!);
                      widget.onboardData.idFrontFile =
                          File(fileProvider.selectedFiles[1].file.path!);
                      widget.onboardData.idBackFile =
                          File(fileProvider.selectedFiles[2].file.path!);

                      docVerify(context, widget.onboardData);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please upload Resume, ID Front, and ID Back");
                    }
                  },
                  textColor: AppTheme.white,
                  border: false,
                  height: 52,
                  backgroundColor: AppTheme.primaryCOlor,
                )
        ],
      ),
    );
  }

  void docVerify(context, TutorOnboardData data) async {
    setState(() {
      isLoading = true;
    });
    print(
        " subject: ${jsonEncode(data.selectedSubjects)}    bankName: ${data.selectedBank}   account Number: ${data.accountNumber?.replaceAll(RegExp(r'\D'), '')}");
    try {
      // Prepare FormData for file upload
      FormData formData = FormData.fromMap({
        "subjects": data.selectedSubjects, // e.g. ["Math", "Science"]
        "bankName": data.selectedBank,
        "accountNumber": data.accountNumber?.replaceAll(RegExp(r'\D'), ''),
        if (data.resumeFile != null)
          "resume": await MultipartFile.fromFile(data.resumeFile!.path,
              filename: 'resume.pdf'),
        if (data.idFrontFile != null)
          "idFront": await MultipartFile.fromFile(data.idFrontFile!.path,
              filename: 'id_front.pdf'),
        if (data.idBackFile != null)
          "idBack": await MultipartFile.fromFile(data.idBackFile!.path,
              filename: 'id_back.pdf'),
      });

      Response response = await dio.post(
        path: AppUrls.onBoard,
        data: formData,
      );

      var responseData = response.data;

      if (response.statusCode == 201) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${responseData["message"]}");

        setState(() {
          isLoading = false;
        });

        pushUntil(context, SubmissionCompleteScreen());
      } else {
        setState(() {
          isLoading = false;
        });
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${responseData["errors"][0]["message"]}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ToastHelper.displayErrorMotionToast(
          context: context, msg: "Something went wrong: $e");
    }
  }
}
