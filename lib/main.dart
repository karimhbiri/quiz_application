import 'package:flutter/material.dart';
import 'package:quiz_application/screens/home_screen.dart'; // Import of HomeScreen
import 'package:quiz_application/screens/quiz_screen.dart'; // Import of QuizScreen
import 'package:quiz_application/screens/quiz_settings_screen.dart'; // Import of QuizSettingsScreen
import 'package:quiz_application/screens/about_screen.dart'; // Import of AboutScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // To track the current theme mode (light or dark)
  ThemeMode _themeMode = ThemeMode.light;

  // Method to toggle the theme
  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Application',
      themeMode: _themeMode,  // Set theme mode here
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,  // Light theme
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,  // Dark theme
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // Home Screen
        '/quiz': (context) => QuizSettingsScreen(), // Quiz Settings Screen
        '/about': (context) => AboutScreen(), // About Screen
      },
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Quiz Application'),
            actions: [
              IconButton(
                icon: Icon(_themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
                onPressed: _toggleTheme,  // Toggle the theme
              ),
            ],
          ),
          body: child,  // The rest of the body content
        );
      },
    );
  }
}
