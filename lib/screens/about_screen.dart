import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('À propos de l\'application')),
      body: Center(
        child: Text('Ceci est une application Flutter pour les quiz.'),
      ),
    );
  }
}
