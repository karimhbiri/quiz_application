import 'package:flutter/material.dart';
import 'package:quiz_application/screens/quiz_settings_screen.dart'; // Import for QuizSettingsScreen
import 'package:quiz_application/screens/about_screen.dart'; // Import for AboutScreen
import 'package:html/parser.dart' as html_parser;

class BaseScreen extends StatelessWidget {
  final Widget child; // The child widget that will be inserted in the body

  BaseScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Application'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.quiz),
              title: Text('Commencer un quiz'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizSettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('À propos de l\'application'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: child, // The child widget will be placed here
    );
  }
}
