import 'dart:io';

class TutorOnboardData {
  List<String> selectedSubjects;
  String? selectedBank;
  String? accountNumber;
  File? resumeFile;
  File? idFrontFile;
  File? idBackFile;

  TutorOnboardData({
    this.selectedSubjects = const [],
    this.selectedBank,
    this.accountNumber,
    this.resumeFile,
    this.idFrontFile,
    this.idBackFile,
  });

  // Optional: Use this for non-file data serialization
  Map<String, dynamic> toJson() {
    return {
      "subjects": selectedSubjects,
      "bank_name": selectedBank,
      "account_number": accountNumber,
    };
  }
}
