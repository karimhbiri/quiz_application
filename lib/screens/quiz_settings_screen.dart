import 'package:flutter/material.dart';
import 'package:quiz_application/services/api_service.dart';
import 'package:quiz_application/screens/quiz_screen.dart'; // Import de l'écran du quiz
import 'package:quiz_application/screens/about_screen.dart'; // Import de l'écran AboutScreen

class QuizSettingsScreen extends StatefulWidget {
  @override
  _QuizSettingsScreenState createState() => _QuizSettingsScreenState();
}

class _QuizSettingsScreenState extends State<QuizSettingsScreen> {
  String? selectedCategory;
  String? selectedDifficulty;
  int numberOfQuestions = 5;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true; // Track loading state for categories

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
      selectedCategory = categories.isNotEmpty ? categories[0]['id'].toString() : null;
      isLoading = false;
    });
  }

  // Validate if all fields are selected before starting the quiz
  bool _isFormValid() {
    return selectedCategory != null && selectedDifficulty != null;
  }

  // Handle menu selection from the Drawer
  void _onMenuItemSelected(String value) {
    if (value == 'quiz') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizSettingsScreen()),
      );
    } else if (value == 'about') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paramètres du quiz')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading spinner while fetching categories
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choisir la catégorie', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
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
                  SizedBox(height: 16),
                  Text('Choisir la difficulté', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
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
                  SizedBox(height: 16),
                  Text('Nombre de questions', style: TextStyle(fontSize: 16)),
                  DropdownButton<int>(
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
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isFormValid()
                        ? () {
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
                          }
                        : null, // Disable the button if form is not valid
                    child: Text('Commencer le quiz'),
                  ),
                ],
              ),
      ),
    );
  }
}
