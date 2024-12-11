import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const UmarahApp());
}

class UmarahApp extends StatefulWidget {
  const UmarahApp({super.key});

  @override
  _UmarahAppState createState() => _UmarahAppState();
}

class _UmarahAppState extends State<UmarahApp> {
  bool _isDarkMode = false; // Initial dark mode state

  // Toggle dark mode
  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value; // Update the theme
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Umrah App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LoginScreen(
        isDarkMode: _isDarkMode,
        toggleDarkMode: _toggleDarkMode,
      ),
    );
  }
}
