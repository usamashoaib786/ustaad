import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class Education {
  final String institute;
  final String startDate;
  final String endDate;
  final String description;

  Education({
    required this.institute,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
}

class EducationProvider with ChangeNotifier {
  final List<Education> _education = [];
  List<Education> get education => _education;

  final AppDio dio;

  EducationProvider(BuildContext context) : dio = AppDio(context);

  Future<void> fetchEducation(context) async {
    try {
      final response = await dio.get(path: AppUrls.getTutorEdu);
      if (response.statusCode == 200) {
        education.clear();
        for (var item in response.data['data']) {
          _education.add(Education(
            institute: item['institute'] ?? '',
            startDate: item['startDate'] ?? '',
            endDate: item['endDate'] ?? '',
            description: item['description'] ?? '',
          ));
        }
        notifyListeners();
      } else {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${response.data["errors"][0]["message"]}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Fetch error: $e");
      }
    }
  }

  Future<bool> addEducation(Education education, context) async {
    Map<String, dynamic> params = {
      "institute": education.institute,
      "startDate": education.startDate,
      "endDate": education.endDate,
      "description": education.description,
    };
    try {
      Response response =
          await dio.post(path: AppUrls.addTutorEdu, data: params);

      if (response.statusCode == 201) {
        _education.add(education);
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${response.data["message"]}");

        notifyListeners();
        return true;
      } else {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${response.data["errors"][0]["message"]}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Add error: $e");
      }
    }
    return false;
  }
}
