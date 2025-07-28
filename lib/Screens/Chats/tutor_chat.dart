import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ustaad/Helpers/app_field.dart';
import 'package:ustaad/Helpers/app_text.dart';
import 'package:ustaad/Helpers/utils.dart';
import 'package:ustaad/Providers/all_chat_provider.dart';
import 'package:ustaad/Screens/Drawer/tutor_drawer.dart';
import 'package:ustaad/Screens/Chats/single_chat_tutor.dart';
import 'package:ustaad/custom%20widgets/app_bar.dart';

class TutorChatScreen extends StatefulWidget {
  const TutorChatScreen({super.key});

  @override
  State<TutorChatScreen> createState() => _TutorChatScreenState();
}

class _TutorChatScreenState extends State<TutorChatScreen> {
  final TextEditingController _search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _didFetch = false;

  @override
  void didChangeDependencies() {
    if (!_didFetch) {
      Provider.of<AllChatProvider>(context, listen: false).fetchChats();
      _didFetch = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<AllChatProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SideMenuDrawer(
        crossOnTap: () {
          _scaffoldKey.currentState?.closeEndDrawer();
        },
        isTutor: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Background.png",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              CustomAppBar(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.appText("Chat",
                          fontWeight: FontWeight.w600, fontSize: 22),
                      const SizedBox(height: 15),
                      CustomAppTextField(
                          texthint: "Search", controller: _search),
                      const SizedBox(height: 10),
                      if (chatProvider.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (chatProvider.chats.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Center(
                            child: AppText.appText("No chat is added yet",
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: chatProvider.chats.length,
                            itemBuilder: (context, index) {
                              final chat = chatProvider.chats[index];
                              return Column(
                                children: [
                                  if (index == 0) const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      push(context, SingleTutorChatScreen());
                                    },
                                    child: ChatTile(
                                      name: chat.name,
                                      message: chat.message,
                                      time: chat.time,
                                      image: chat.image,
                                      isOnline: chat.isOnline,
                                    ),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              );
                            },
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
