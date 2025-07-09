import 'dart:io';
import 'package:flutter/material.dart';

class ChildProfileModel {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController grade = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController schoolName = TextEditingController();
  String? selectedGender;
  File? selectedImage;

  void clear() {
    fullName.clear();
    grade.clear();
    age.clear();
    schoolName.clear();
    selectedGender = null;
    selectedImage = null;
  }
}
