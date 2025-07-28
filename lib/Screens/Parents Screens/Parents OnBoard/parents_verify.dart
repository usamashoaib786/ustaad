import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Providers/tutor_veirfy_provider.dart';
import 'package:ustaad/Screens/Teacher%20Screens/0nBoard%20Screens/submission_screen.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class ParentsVerificationSCreen extends StatefulWidget {
  const ParentsVerificationSCreen({super.key});

  @override
  State<ParentsVerificationSCreen> createState() =>
      _ParentsVerificationSCreenState();
}

class _ParentsVerificationSCreenState extends State<ParentsVerificationSCreen> {
  bool isLoading = false;
  late AppDio dio;

  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
  }

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 20),
          _buildUploadBox(fileProvider),
          const SizedBox(height: 20),
          _buildFileList(fileProvider),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : AppButton.appButton(
                  "Proceed",
                  context: context,
                  onTap: () => uploadDocuments(context),
                  textColor: AppTheme.white,
                  border: false,
                  height: 52,
                  backgroundColor: AppTheme.primaryCOlor,
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text.rich(
      TextSpan(
        text: 'Upload Your ',
        style: TextStyle(
            fontSize: 44, color: AppTheme.black, fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: 'Documents',
            style: TextStyle(
                color: AppTheme.appColor,
                fontWeight: FontWeight.w600,
                fontSize: 44),
          ),
          const TextSpan(text: ' For Your '),
          TextSpan(
            text: 'Verifications',
            style: TextStyle(
                color: AppTheme.appColor,
                fontWeight: FontWeight.w600,
                fontSize: 44),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox(FileProvider fileProvider) {
    return GestureDetector(
      onTap: () => fileProvider.pickFile(),
      child: Container(
        height: 160,
        width: ScreenSize(context).width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.borderCOlor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset('assets/images/docVerify.png', height: 70),
            AppText.appText("Tap To Upload Documents",
                fontSize: 16, fontWeight: FontWeight.w500),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.appText("1. ",
                    fontSize: 14, textColor: const Color(0xFF9BA2B3)),
                AppText.appText("ID Card / License / Passport",
                    fontSize: 14, textColor: const Color(0xffA6ADBF)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileList(FileProvider fileProvider) {
    return Expanded(
      child: ListView.builder(
        itemCount: fileProvider.selectedFiles.length,
        itemBuilder: (context, index) {
          final file = fileProvider.selectedFiles[index].file;
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            color: AppTheme.white,
            child: Container(
              height: 75,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      const SizedBox(height: 5),
                      Text("${(file.size / 1024).toStringAsFixed(1)} KB"),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => fileProvider.removeFile(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void uploadDocuments(context) async {
    final fileProvider = Provider.of<FileProvider>(context, listen: false);

    if (fileProvider.selectedFiles.length < 2) {
      ToastHelper.displayErrorMotionToast(
          context: context, msg: "Please upload both ID Front and Back.");
      return;
    }

    setState(() => isLoading = true);

    try {
      final idFront = fileProvider.selectedFiles[0].file;
      final idBack = fileProvider.selectedFiles[1].file;

      final formData = FormData.fromMap({
        "idFront":
            await MultipartFile.fromFile(idFront.path!, filename: idFront.name),
        "idBack":
            await MultipartFile.fromFile(idBack.path!, filename: idBack.name),
      });

      final response =
          await dio.post(path: AppUrls.parentOnBoard, data: formData);
      final data = response.data;

      if (response.statusCode == 201) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${data["message"]}");
        fileProvider.clearAll();
        pushUntil(
            context,
            const SubmissionCompleteScreen(
              tutor: false,
            ));
      } else {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: data["errors"][0]["message"]);
      }
    } catch (e) {
      ToastHelper.displayErrorMotionToast(
          context: context, msg: "Upload failed: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }
}
