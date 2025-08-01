import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ustaad/Models/child_detail_model.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class ParentProfileProvider with ChangeNotifier {
  List<Child> _children = [];
  Child? _selectedChild;
  bool _isLoading = false;

  final AppDio _dio;

  ParentProfileProvider(BuildContext context) : _dio = AppDio(context);

  List<Child> get children => _children;
  Child? get selectedChild => _selectedChild;
  bool get isLoading => _isLoading;

  Future<void> fetchChildren() async {
    if (children.isEmpty) {
      _isLoading = true;
      notifyListeners();
    }

    try {
      final response = await _dio.get(path: AppUrls.getChildren);
      final data = response.data["data"] as List;
      _children = data.map((json) => Child.fromJson(json)).toList();

      if (_children.isNotEmpty) {
        _selectedChild = _children.first;
      }

    } catch (e) {
      debugPrint("Error fetching children: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectChild(Child child) {
    _selectedChild = child;
    notifyListeners();
  }

  Future<void> addChild({
    required String fullName,
    required String grade,
    required String age,
    required String schoolName,
    required String gender,
    XFile? imageFile,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> body = {
        "fullName": fullName,
        "grade": grade,
        "age": age,
        "schoolName": schoolName,
        "gender": gender,
        "image": imageFile != null
            ? "data:image/jpeg;base64,${base64Encode(File(imageFile.path).readAsBytesSync())}"
            : "",
      };

      final response = await _dio.post(path: AppUrls.addChild, data: body);

      final newChild = Child.fromJson(response.data['data']);
      _children.add(newChild);
      _selectedChild = newChild;

      notifyListeners();
    } catch (e) {
      debugPrint("Error adding child: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
