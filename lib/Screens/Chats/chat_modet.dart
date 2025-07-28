class ChatMessage {
  final String text;
  final String time;
  final bool isMe;
  final bool isVoice;

  ChatMessage({
    required this.text,
    required this.time,
    this.isMe = false,
    this.isVoice = false,
  });
}
