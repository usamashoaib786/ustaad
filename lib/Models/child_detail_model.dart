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