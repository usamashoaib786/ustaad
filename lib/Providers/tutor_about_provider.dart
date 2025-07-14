import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class About {
  final String about;
  final int grade;
  final List<String> subjects;

  About({
    required this.about,
    required this.grade,
    required this.subjects,
  });
}

class AboutProvider with ChangeNotifier {
  About? _aboutData;
  About? get aboutData => _aboutData;

  bool get hasAbout => _aboutData != null && _aboutData!.about.isNotEmpty;

  final AppDio dio;

  AboutProvider(BuildContext context) : dio = AppDio(context);

  Future<void> fetchAboutData(context) async {
    try {
      final response = await dio.get(path: AppUrls.getTutorProfile);

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final tutor = data['Tutor'];

        if (tutor != null) {
          _aboutData = About(
            about: tutor['about'] ?? '',
            grade: int.tryParse(tutor['grade'].toString()) ?? 0,
            subjects: tutor['subjects'] != null
                ? List<String>.from(tutor['subjects'])
                : [],
          );
        } else {
          _aboutData = null;
          ToastHelper.displayErrorMotionToast(
              context: context,
              msg: "${response.data["errors"][0]["message"]}");
        }

        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print("Fetch About Error: $e");
    }
  }

  Future<bool> addAboutData(String about, int grade, context) async {
    Map<String, dynamic> body = {
      "about": about,
      "grade": grade,
    };

    try {
      final response = await dio.post(path: AppUrls.addAbout, data: body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        ToastHelper.displaySuccessMotionToast(
          context: context,
          msg: response.data["message"] ?? "About added successfully",
        );
        await fetchAboutData(context); // Refresh
        return true;
      } else {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${response.data["errors"][0]["message"]}");
      }
    } catch (e) {
      if (kDebugMode) print("Add About Error: $e");
    }

    return false;
  }

  Future<bool> updateAboutData(String about, int grade, context) async {
    Map<String, dynamic> body = {
      "about": about,
      "grade": grade.toString(),
    };

    try {
      final response = await dio.post(path: AppUrls.editAbout, data: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _aboutData = About(
          about: about,
          grade: grade,
          subjects: _aboutData?.subjects ?? [],
        );
        ToastHelper.displaySuccessMotionToast(
          context: context,
          msg: "About updated successfully",
        );
        notifyListeners();
        return true;
      } else {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${response.data["errors"][0]["message"]}");
      }
    } catch (e) {
      if (kDebugMode) print("Update About Error: $e");
    }

    return false;
  }
}
