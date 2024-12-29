import 'package:flutter/material.dart';
import 'quiz_settings_screen.dart'; // Import for QuizSettingsScreen
import 'home_screen.dart'; // Import for HomeScreen

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultScreen({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Résultats')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Votre score: $score / $totalQuestions',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20), // Add space between the score and buttons
            // Button to go back to Quiz Settings screen
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizSettingsScreen()),
                );
              },
              icon: Icon(Icons.settings), // Icon for settings
              label: Text('Retour aux paramètres du quiz'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), // Set fixed size for button
              ),
            ),
            SizedBox(height: 10), // Space between buttons
            // Button to go back to Home Screen
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.home), // Icon for home
              label: Text('Retour à l\'accueil'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), // Set fixed size for button
              ),
            ),
            SizedBox(height: 10), // Space between buttons
            // Button to Replay the Quiz
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.refresh), // Icon for replay
              label: Text('Rejouer'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), // Set fixed size for button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
