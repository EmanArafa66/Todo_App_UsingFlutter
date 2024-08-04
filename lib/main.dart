// Importing necessary packages
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

// Entry point of the Flutter application
void main() {
  // Running the app
  runApp(MyApp());
}

// MyApp class which is the root of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title of the application
      title: 'Todo List App',
      // Disabling the debug banner
      debugShowCheckedModeBanner: false,
      // Setting the theme for the application
      theme: ThemeData(
        // Primary color of the application
        primarySwatch: Colors.blue,
        // Adaptive platform density for visual consistency across different devices
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Setting the home screen of the application to SplashScreen
      home: SplashScreen(),
    );
  }
}
