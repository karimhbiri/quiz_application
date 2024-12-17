import 'package:flutter/material.dart';
import 'package:quiz_application/screens/home_screen.dart'; // Import de l'écran d'accueil
import 'package:quiz_application/screens/quiz_screen.dart'; // Import de l'écran du quiz
import 'package:quiz_application/screens/quiz_settings_screen.dart'; // Import des paramètres du quiz

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // Écran d'accueil
        '/quiz': (context) => QuizSettingsScreen(), // Écran des paramètres du quiz
      },
    );
  }
}
