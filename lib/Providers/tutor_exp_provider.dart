import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/toaster.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class Experience {
  final String company;
  final String startDate;
  final String endDate;
  final String description;

  Experience({
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
}

class ExperienceProvider with ChangeNotifier {
  final List<Experience> _experiences = [];
  List<Experience> get experiences => _experiences;

  final AppDio dio;

  ExperienceProvider(BuildContext context) : dio = AppDio(context);

  Future<void> fetchExperiences(context) async {
    try {
      final response = await dio.get(path: AppUrls.getTutorExp);
      if (response.statusCode == 201) {
        _experiences.clear();
        for (var item in response.data['data']) {
          _experiences.add(Experience(
            company: item['company'] ?? '',
            startDate: item['startDate'] ?? '',
            endDate: item['endDate'] ?? '',
            description: item['description'] ?? '',
          ));
        }
        notifyListeners();
      }else {
        ToastHelper.displayErrorMotionToast(
            context: context, msg: "${response.data["errors"][0]["message"]}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Fetch error: $e");
      }
    }
  }

  Future<bool> addExperience(Experience experience, context) async {
    Map<String, dynamic> params = {
      "company": experience.company,
      "startDate": experience.startDate,
      "endDate": experience.endDate,
      "description": experience.description,
    };
    try {
      Response response =
          await dio.post(path: AppUrls.addTutorExp, data: params);

      if (response.statusCode == 201) {
        _experiences.add(experience);
        ToastHelper.displaySuccessMotionToast(
            context: context, msg: "${response.data["message"]}");

        notifyListeners();
        return true;
      }else {
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
