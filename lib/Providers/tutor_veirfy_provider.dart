import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SelectedFile {
  final PlatformFile file;

  SelectedFile(this.file);
}

class FileProvider with ChangeNotifier {
  List<SelectedFile> selectedFiles = [];

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedFiles.add(SelectedFile(result.files.first));
      notifyListeners();
    }
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index);
    notifyListeners();
  }
}
