import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ustaad/Screens/Authentication/auth_widgets.dart';
import 'package:ustaad/config/dio/app_logger.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class Child {
  final String id;
  final String name;
  final String age;
  final String school;
  final String gender;
  final String grade;

  Child({
    required this.id,
    required this.name,
    required this.age,
    required this.school,
    required this.gender,
    required this.grade,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] ?? '',
      name: json['fullName'] ?? '',
      age: json['age'].toString(),
      school: json['schoolName'] ?? '',
      gender: json['gender'] ?? '',
      grade: json['grade'] ?? '',
    );
  }
}

class ChildDetails extends StatefulWidget {
  final String userId;
  const ChildDetails({super.key, required this.userId});

  @override
  State<ChildDetails> createState() => _ChildDetailsState();
}

class _ChildDetailsState extends State<ChildDetails> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  List<Child> childList = [];
  Child? selectedChild;
  bool isLoading = false;
  late AppDio dio;
  AppLogger logger = AppLogger();

  @override
  void initState() {
    super.initState();
    dio = AppDio(context);
    fetchChildren();
  }

  Future<void> fetchChildren() async {
    setState(() => isLoading = true);

    try {
      Response response = await dio.get(path: AppUrls.getChildren);
      final data = response.data["data"] as List;
      childList = data.map((json) => Child.fromJson(json)).toList();

      if (childList.isNotEmpty) {
        selectedChild = childList.first;
        _populateFields(selectedChild!);
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error fetching children: $e");
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _populateFields(Child child) {
    _ageController.text = child.age;
    _schoolController.text = child.school;
    _genderController.text = child.gender;
    _gradeController.text = child.grade;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: DropdownButtonFormField<Child>(
                  value: selectedChild,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  items: childList.map((child) {
                    return DropdownMenuItem<Child>(
                      value: child,
                      child: Text(
                        child.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (Child? value) {
                    if (value != null) {
                      setState(() {
                        selectedChild = value;
                        _populateFields(value);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              customLableField(lable: "Age", controller: _ageController),
              const SizedBox(height: 20),
              customLableField(lable: "School", controller: _schoolController),
              const SizedBox(height: 20),
              customLableField(lable: "Class", controller: _gradeController),
              const SizedBox(height: 20),
              customLableField(lable: "Gender", controller: _genderController),
              const SizedBox(height: 20),
            ],
          );
  }
}
