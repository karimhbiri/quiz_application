import 'package:flutter/material.dart';
import 'quiz_settings_screen.dart'; // Import de l'écran de paramétrage du quiz

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigation vers l'écran des paramètres du quiz
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizSettingsScreen()),
                );
              },
              child: Text('Commencer un quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
