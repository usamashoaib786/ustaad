class TutorModel {
  final String tutorId;
  final String parentId;
  final String name;
  final String subject;
  final double rating;

  TutorModel({
    required this.tutorId,
    required this.parentId,
    required this.name,
    required this.subject,
    required this.rating,
  });

  factory TutorModel.fromJson(Map<String, dynamic> json) {
    return TutorModel(
      tutorId: json['tutorId'] ?? '',
      name: json['tutor']?['fullName'] ?? 'Unknown',
      subject: json['address'] ?? 'Unknown Area',
      rating: (json['rating'] ?? 5.0).toDouble(),
      parentId: json['id'] ?? '',
    );
  }
}
