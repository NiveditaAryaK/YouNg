import 'package:flutter/material.dart';
import 'chatbot_screen.dart';
import 'profile_screen.dart';
import 'homescreencontent.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);  // Start on HomeScreen
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          ProfileScreen(),  // Profile Screen
          HomeScreenContent(),
          ChatbotScreen(),  // Chatbot Screen  // Home Screen
        ],
        onPageChanged: (index) {
          // Optionally, you can handle page changes here
        },
      ),
    );
  }
}
