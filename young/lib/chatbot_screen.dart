import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message.dart';  // Import the Message class
import 'fashion_recomendation_service.dart';  // Import the function
import 'welcome_screen.dart';  // Import the WelcomeScreen class
import 'stored_helper.dart';  // Import the storage helper functions

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    final messages = await loadChatHistory();
    setState(() {
      _messages = messages;
    });
  }

  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.add(Message(text: text, isUser: true));
    });

    try {
      // Get fashion recommendation from the AI model
      final recommendation = await getFashionRecommendation(_messages);

      setState(() {
        _messages.add(Message(text: recommendation, isUser: false));
      });

      // Save the updated chat history
      await saveChatHistory(_messages);
    } catch (e) {
      setState(() {
        _messages.add(Message(text: 'Error: $e', isUser: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Chatbot'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      color: message.isUser ? Colors.blueAccent : Colors.grey[300],
                      child: Text(
                        message.text,
                        style: TextStyle(color: message.isUser ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text;
                    if (text.isNotEmpty) {
                      _sendMessage(text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
