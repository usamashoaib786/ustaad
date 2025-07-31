import 'package:flutter/material.dart';
import 'package:ustaad/Models/child_detail_model.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class ParentProfileProvider with ChangeNotifier {
  List<Child> _children = [];
  Child? _selectedChild;
  bool _isLoading = false;
  bool _isFetched = false; // NEW

  final AppDio _dio;

  ParentProfileProvider(BuildContext context) : _dio = AppDio(context);

  List<Child> get children => _children;
  Child? get selectedChild => _selectedChild;
  bool get isLoading => _isLoading;

  Future<void> fetchChildren() async {
    if (_isFetched) return; // Already fetched
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get(path: AppUrls.getChildren);
      final data = response.data["data"] as List;
      _children = data.map((json) => Child.fromJson(json)).toList();

      if (_children.isNotEmpty) {
        _selectedChild = _children.first;
      }

      _isFetched = true; // Mark as fetched
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
}
