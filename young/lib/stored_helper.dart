import 'package:shared_preferences/shared_preferences.dart';
import 'message.dart';  // Import the Message class
import 'dart:convert';

Future<List<Message>> loadChatHistory() async {
  final prefs = await SharedPreferences.getInstance();
  final historyString = prefs.getString('chat_history') ?? '[]';
  final List<dynamic> jsonList = jsonDecode(historyString);

  return jsonList.map((json) => Message(text: json['text'], isUser: json['isUser'])).toList();
}

Future<void> saveChatHistory(List<Message> messages) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = messages.map((msg) => {'text': msg.text, 'isUser': msg.isUser}).toList();
  final historyString = jsonEncode(jsonList);
  await prefs.setString('chat_history', historyString);
}
