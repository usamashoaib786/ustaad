import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/app_theme.dart';
import 'package:ustaad/Helpers/screen_size.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Chats/chat_modet.dart';

class SingleTutorChatScreen extends StatelessWidget {
  final List<ChatMessage> messages = [
    ChatMessage(text: "Hello! Jhon abraham", time: "09:25 AM", isMe: true),
    ChatMessage(text: "Hello ! Nazrul How are you?", time: "09:25 AM"),
    ChatMessage(text: "You did your job well!", time: "09:25 AM", isMe: true),
    ChatMessage(text: "Have a great working week!!", time: "", isMe: false),
    ChatMessage(text: "Hope you like it", time: "09:25 AM", isMe: false),
    ChatMessage(text: "", time: "09:25 AM", isMe: true, isVoice: true),
  ];

  SingleTutorChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryCOlor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 40, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo1.png', height: 50),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset("assets/images/walletChat.png"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            "assets/images/menu.png",
                            color: AppTheme.primaryCOlor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: ScreenSize(context).width,
              decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: LinearGradient(colors: [
                            AppTheme.appColor,
                            AppTheme.primaryCOlor,
                            AppTheme.primaryCOlor
                          ])),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage("assets/images/user.png"),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.appText("Ali Ahmed",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  textColor: Colors.white),
                              AppText.appText("Connected Since 2 months",
                                  fontSize: 12, textColor: Colors.white70),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Chat list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return ChatBubble(message: messages[index]);
                      },
                    ),
                  ),

                  // // Bottom input bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/attachment.png",
                          height: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomAppTextField(
                            texthint: "Write your message",
                            hintStyle: TextStyle(color: Colors.grey),
                            controller: null,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          "assets/images/camera.png",
                          height: 24,
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          "assets/images/microphone.png",
                          height: 24,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = message.isMe ? Color(0xFF0D9DC2) : Color(0xFFF3F5F9);
    final textColor = message.isMe ? Colors.white : Colors.black;
    final radius = message.isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          padding: message.isVoice
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 4),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius,
          ),
          child: message.isVoice
              ? Row(
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        height: 4,
                        color: Colors.white,
                      ),
                    ),
                    AppText.appText("00:16",
                        textColor: Colors.white, fontSize: 12),
                  ],
                )
              : AppText.appText(message.text,
                  textColor: textColor, fontSize: 14),
        ),
        AppText.appText(message.time, fontSize: 12, textColor: Colors.grey),
      ],
    );
  }
}
