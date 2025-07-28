class ChatModel {
  final String name;
  final String message;
  final String time;
  final String image;
  final bool isOnline;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    required this.isOnline,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      name: json['name'],
      message: json['message'],
      time: json['time'],
      image: json['image'],
      isOnline: json['isOnline'],
    );
  }
}
