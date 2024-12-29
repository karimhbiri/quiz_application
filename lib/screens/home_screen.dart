import 'package:flutter/material.dart';
import 'package:quiz_application/screens/quiz_settings_screen.dart'; // Import for QuizSettingsScreen
import 'package:quiz_application/screens/about_screen.dart'; // Import for AboutScreen
import 'package:quiz_application/screens/base_screen.dart'; 

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: Text(
          'Bienvenue dans l\'application !',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
