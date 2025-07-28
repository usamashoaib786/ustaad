class SubjectModel {
  String name;
  bool enabled;
  String cost;

  SubjectModel({required this.name, required this.enabled, required this.cost});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      name: json['name'],
      enabled: json['enabled'] ?? false,
      cost: json['cost'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'enabled': enabled,
      'cost': cost,
    };
  }
}
