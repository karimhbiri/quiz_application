import 'package:flutter/material.dart';
import 'package:quiz_application/services/api_service.dart';
import 'package:quiz_application/models/quiz_question.dart';
import 'quiz_screen.dart'; // Import de l'écran du quiz

class QuizSettingsScreen extends StatefulWidget {
  @override
  _QuizSettingsScreenState createState() => _QuizSettingsScreenState();
}

class _QuizSettingsScreenState extends State<QuizSettingsScreen> {
  String? selectedCategory;
  String? selectedDifficulty;
  int numberOfQuestions = 5;
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // Récupérer les catégories via l'API
  void _fetchCategories() async {
    ApiService apiService = ApiService();
    var fetchedCategories = await apiService.fetchCategories();
    setState(() {
      categories = fetchedCategories;
      selectedCategory = categories[0]['id'].toString(); // Sélectionner la première catégorie par défaut
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paramètres du quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Choisir la catégorie'),
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              items: categories
                  .map((category) => DropdownMenuItem<String>(
                        value: category['id'].toString(),
                        child: Text(category['name']),
                      ))
                  .toList(),
            ),
            DropdownButton<String>(
              hint: Text('Choisir la difficulté'),
              value: selectedDifficulty,
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value;
                });
              },
              items: ['easy', 'medium', 'hard']
                  .map((difficulty) => DropdownMenuItem<String>(
                        value: difficulty,
                        child: Text(difficulty),
                      ))
                  .toList(),
            ),
            DropdownButton<int>(
              hint: Text('Nombre de questions'),
              value: numberOfQuestions,
              onChanged: (value) {
                setState(() {
                  numberOfQuestions = value!;
                });
              },
              items: [5, 10, 15]
                  .map((number) => DropdownMenuItem<int>(
                        value: number,
                        child: Text(number.toString()),
                      ))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers l'écran du quiz avec les paramètres sélectionnés
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      category: selectedCategory!,
                      difficulty: selectedDifficulty!,
                      numberOfQuestions: numberOfQuestions,
                    ),
                  ),
                );
              },
              child: Text('Commencer le quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
