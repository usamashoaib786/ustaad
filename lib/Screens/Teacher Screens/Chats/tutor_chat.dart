import 'package:flutter/material.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Screens/Teacher%20Screens/Chats/single_chat_tutor.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';

class TutorChatScreen extends StatefulWidget {
  const TutorChatScreen({super.key});

  @override
  State<TutorChatScreen> createState() => _TutorChatScreenState();
}

class _TutorChatScreenState extends State<TutorChatScreen> {
  final TextEditingController _search = TextEditingController();
  final List<Map<String, dynamic>> chatData = [
    {
      "name": "Sara Ali",
      "message": "Quisque vestibulum pulvinar lorem eget",
      "time": "2min ago",
      "image": "assets/images/user.png",
      "isOnline": true
    },
    {
      "name": "Amna",
      "message": "Interdum et malesuada fames ac ante",
      "time": "2min ago",
      "image": "assets/images/user.png",
      "isOnline": true
    },
    {
      "name": "Zulqarnain",
      "message": "ipsum primis in faucibus",
      "time": "2min ago",
      "image": "assets/images/user.png",
      "isOnline": false
    },
    {
      "name": "Theresa Web",
      "message": "Ut condimentum efficitur lorem eu mollis.",
      "time": "2min ago",
      "image": "assets/images/user.png",
      "isOnline": false
    },
    {
      "name": "Amir",
      "message": "Vestibulum ante ipsum primis in faucibus",
      "time": "2min ago",
      "image": "assets/images/user.png",
      "isOnline": true
    },
    {
      "name": "Usman",
      "message": "orci luctus et ultrices posuere cubilia curae",
      "time": "2min ago",
      "image": "assets/images/user.png",
      "isOnline": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.appText("Chat", fontWeight: FontWeight.w600, fontSize: 22),
            SizedBox(
              height: 15,
            ),
            CustomAppTextField(texthint: "Search", controller: _search),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: chatData.length,
                itemBuilder: (context, index) {
                  final chat = chatData[index];
                  return Column(
                    children: [
                      if (index == 0)
                        SizedBox(
                          height: 20,
                        ),
                      InkWell(
                        onTap: () {
                          push(context, SingleTutorChatScreen());
                        },
                        child: ChatTile(
                          name: chat['name'],
                          message: chat['message'],
                          time: chat['time'],
                          image: chat['image'],
                          isOnline: chat['isOnline'],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  final bool isOnline;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.appText(
                name,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              const SizedBox(height: 4),
              AppText.appText(
                message,
                fontSize: 14,
                textColor: Colors.grey,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppText.appText(
              time,
              fontSize: 12,
              textColor: Colors.grey,
            ),
            const SizedBox(height: 8),
            isOnline
                ? Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  )
                : const SizedBox(height: 8),
          ],
        )
      ],
    );
  }
}
