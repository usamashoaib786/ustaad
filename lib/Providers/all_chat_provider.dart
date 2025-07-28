import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ustaad/Models/all_chat_model.dart';
import 'package:ustaad/config/dio/dio.dart';
import 'package:ustaad/config/keys/urls.dart';

class AllChatProvider with ChangeNotifier {
  final AppDio dio;

  List<ChatModel> _chats = [];
  bool _isLoading = true;

  AllChatProvider(BuildContext context) : dio = AppDio(context);

  List<ChatModel> get chats => _chats;
  bool get isLoading => _isLoading;

  Future<void> fetchChats() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await dio.get(path: AppUrls.getAllChat);

      final data = response.data['data'] as List;
      _chats = data.map((json) => ChatModel.fromJson(json)).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Fetch error: $e");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
