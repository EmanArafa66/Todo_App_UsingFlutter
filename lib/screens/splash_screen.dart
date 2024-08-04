// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_list_screen.dart';

// A stateful widget that represents the splash screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen(); // Navigate to the main screen after a delay
  }

  // Method to navigate to the main screen after a delay
  void _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 5), () {}); // Wait for 5 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => TodoListScreen()), // Navigate to TodoListScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/todo.png', // Display the splash image
              width: 150, // Set the width of the image
            ),
            SizedBox(height: 20), // Space between image and text
            Text(
              'Todo List App', // App title
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold), // Text style
            ),
          ],
        ),
      ),
    );
  }
}
