import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';  // Import HomeScreen here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',  // Updated the title for consistency
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),  // Set the initial screen to WelcomeScreen
      routes: {
        // Define routes for navigation
        '/home': (context) => HomeScreen(),  // Add the route for HomeScreen
      },
    );
  }
}
