import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ustaad/Helpers/app_button.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/Models/add_child_model.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class ParentChildProfile extends StatefulWidget {
  final Function()? onTap;
  const ParentChildProfile({super.key, this.onTap});

  @override
  State<ParentChildProfile> createState() => _ParentChildProfileState();
}

class _ParentChildProfileState extends State<ParentChildProfile> {
  final List<ChildProfileModel> childList = [ChildProfileModel()];
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  late AppDio dio;

  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentChild = childList.last;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'To Continue.. Just ',
                style: TextStyle(
                  fontSize: 44,
                  color: AppTheme.black,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: 'Add',
                    style: TextStyle(
                      color: AppTheme.appColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 44,
                    ),
                  ),
                  TextSpan(text: ' Your '),
                  TextSpan(
                    text: "Child's Profile",
                    style: TextStyle(
                      color: AppTheme.appColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 44,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Summary
            ...List.generate(childList.length, (i) {
              final child = childList[i];
              final title = child.fullName.text.isNotEmpty
                  ? child.fullName.text
                  : "Add details of your child";

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    AppText.appText(
                      "Child ${i + 1}: ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    AppText.appText(
                      title,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 10),
            // Form for last child
            buildChildForm(currentChild, childList.length),
            const SizedBox(height: 20),

            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      AppButton.appButton("Add Another Child",
                          context: context,
                          onTap: () => addSingleChild(currentChild),
                          textColor: AppTheme.black,
                          border: true,
                          height: 44,
                          borderColor: const Color(0xffD4D8E2),
                          backgroundColor: Colors.transparent),
                      const SizedBox(height: 12),
                      AppButton.appButton("Proceed",
                          context: context,
                          onTap: () => submitLastChildAndProceed(currentChild),
                          textColor: AppTheme.white,
                          border: false,
                          height: 44,
                          backgroundColor: AppTheme.primaryCOlor),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildChildForm(ChildProfileModel child, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage: child.selectedImage != null
                  ? FileImage(child.selectedImage!)
                  : const AssetImage("assets/images/user.png") as ImageProvider,
            ),
            Column(
              children: [
                AppButton.appButton("Upload New",
                    context: context,
                    width: 200,
                    onTap: () => _pickImage(index - 1),
                    backgroundColor: const Color(0xffF1FCF9),
                    border: false,
                    textColor: AppTheme.appColor),
                SizedBox(
                  height: 10,
                ),
                AppButton.appButton("Delete Image",
                    context: context,
                    width: 200,
                    onTap: () => _deleteImage(index - 1),
                    backgroundColor: const Color(0xffFEECEC),
                    border: false,
                    textColor: Colors.red),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        customLableField(lable: "Child Full Name", controller: child.fullName),
        const SizedBox(height: 20),
        AppText.appText("Gender",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppTheme.lableText),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _genderTile("Male", child),
            _genderTile("Female", child),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customLableField(
                lable: "Grade",
                width: ScreenSize(context).width * 0.4,
                controller: child.grade),
            customLableField(
                lable: "Age",
                width: ScreenSize(context).width * 0.4,
                controller: child.age),
          ],
        ),
        const SizedBox(height: 20),
        customLableField(lable: "School Name", controller: child.schoolName),
      ],
    );
  }

  Widget _genderTile(String gender, ChildProfileModel child) {
    return GestureDetector(
      onTap: () => setState(() => child.selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 44,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(
            color: child.selectedGender == gender
                ? AppTheme.appColor
                : const Color(0xffD4D8E2),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: gender,
              groupValue: child.selectedGender,
              activeColor: AppTheme.appColor,
              onChanged: (value) =>
                  setState(() => child.selectedGender = value),
            ),
            Text(gender),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => childList[index].selectedImage = File(pickedFile.path));
    }
  }

  void _deleteImage(int index) {
    setState(() => childList[index].selectedImage = null);
  }

  Future<void> addSingleChild(ChildProfileModel child) async {
    if (!validateFields(child)) return;

    setState(() => isLoading = true);

    final Map<String, dynamic> body = {
      "fullName": child.fullName.text.trim(),
      "gender": child.selectedGender!.toLowerCase(),
      "grade": child.grade.text.trim(),
      "age": child.age.text.trim(),
      "schoolName": child.schoolName.text.trim(),
      "image": child.selectedImage != null
          ? "data:image/jpeg;base64,${base64Encode(child.selectedImage!.readAsBytesSync())}"
          : "",
    };

    try {
      final response = await dio.post(path: AppUrls.addChild, data: body);
      final data = response.data;

      if (response.statusCode == 201) {
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${data["message"]}");

        // Add new empty form
        setState(() => childList.add(ChildProfileModel()));
      } else {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: data["error"][0]["message"]);
      }
    } catch (e) {
      ToastHelper.displayErrorMotionToast(context: context, msg: "Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> submitLastChildAndProceed(ChildProfileModel child) async {
    final isAllEmpty = child.fullName.text.isEmpty &&
        child.grade.text.isEmpty &&
        child.age.text.isEmpty &&
        child.schoolName.text.isEmpty &&
        child.selectedGender == null &&
        child.selectedImage == null;

    if (isAllEmpty && childList.length == 1) {
      ToastHelper.displayErrorMotionToast(
          context: context,
          msg: "Please add at least one child before proceeding.");
      return;
    }

    if (!isAllEmpty) {
      await addSingleChild(child);
    }
    if (widget.onTap != null) widget.onTap!();
  }

  bool validateFields(ChildProfileModel child) {
    if (child.fullName.text.isEmpty ||
        child.age.text.isEmpty ||
        child.grade.text.isEmpty ||
        child.schoolName.text.isEmpty ||
        child.selectedGender == null) {
      ToastHelper.displayErrorMotionToast(
          context: context, msg: "Please fill all required fields.");
      return false;
    }

    if (child.selectedImage == null) {
      ToastHelper.displayErrorMotionToast(
          context: context, msg: "Please upload an image.");
      return false;
    }

    return true;
  }
}
