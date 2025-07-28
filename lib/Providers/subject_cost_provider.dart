import 'package:flutter/material.dart';
import 'package:ustaad/Models/subject_cost_model.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class CostSettingProvider with ChangeNotifier {
  int minSubjects = 0;
  int maxStudents = 0;
  bool isFirstTime = true;
  bool isLoading = false;

  List<SubjectModel> subjects = [];

  final AppDio dio;
  CostSettingProvider(BuildContext context) : dio = AppDio(context);

  Future<void> fetchCostSettings() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await dio.get(path: AppUrls.getcostsetting);

      if (response.statusCode == 200) {
        final data = response.data;
        minSubjects = data['minSubjects'];
        maxStudents = data['maxStudents'];
        subjects = (data['subjects'] as List)
            .map((item) => SubjectModel.fromJson(item))
            .toList();
        isFirstTime = false;
      }
    } catch (e) {
      isFirstTime = true;
      debugPrint('Fetch error: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> saveCostSettings() async {
    final body = {
      'minSubjects': minSubjects,
      'maxStudents': maxStudents,
      'subjects': subjects.map((e) => e.toJson()).toList(),
    };

    try {
      if (isFirstTime) {
        await dio.post(
            path: 'https://yourapi.com/api/cost-settings', data: body);
      } else {
        await dio.put(
            path: 'https://yourapi.com/api/cost-settings', data: body);
      }
    } catch (e) {
      debugPrint('Save error: $e');
    }
  }

  void updateSubject(int index, SubjectModel updated) {
    subjects[index] = updated;
    notifyListeners();
  }

  void addSubject(SubjectModel subject) {
    subjects.add(subject);
    notifyListeners();
  }

  void updateMinSubjects(int value) {
    minSubjects = value;
    notifyListeners();
  }

  void updateMaxStudents(int value) {
    maxStudents = value;
    notifyListeners();
  }
}
