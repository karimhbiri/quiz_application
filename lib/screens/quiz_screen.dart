import 'package:flutter/material.dart';
import 'package:quiz_application/models/quiz_question.dart';
import 'package:quiz_application/services/api_service.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final String difficulty;
  final int numberOfQuestions;

  QuizScreen({
    required this.category,
    required this.difficulty,
    required this.numberOfQuestions,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<QuizQuestion>> questions;
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  String? selectedAnswer; // Store the selected answer

  @override
  void initState() {
    super.initState();
    questions = ApiService().fetchQuestions(
      widget.category,
      widget.difficulty,
      widget.numberOfQuestions,
    );
  }

  void checkAnswer(String selectedOption, String correctAnswer) {
    if (selectedOption == correctAnswer) {
      setState(() {
        score++;
      });
    }
    setState(() {
      isAnswered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: FutureBuilder<List<QuizQuestion>>(
        future: questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune question disponible.'));
          }

          QuizQuestion currentQuestion = snapshot.data![currentQuestionIndex];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currentQuestion.question,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ...currentQuestion.options.map((option) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      selectedAnswer == option
                          ? (option == currentQuestion.correctAnswer
                              ? Colors.green
                              : Colors.red)
                          : Colors.blue,
                    ),
                  ),
                  onPressed: isAnswered
                      ? null
                      : () {
                          setState(() {
                            selectedAnswer = option; // Store the selected answer
                          });
                          checkAnswer(option, currentQuestion.correctAnswer); // Check the answer
                        },
                  child: Text(option),
                );
              }).toList(),
              if (isAnswered)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentQuestionIndex < snapshot.data!.length - 1) {
                        currentQuestionIndex++;
                        selectedAnswer = null; // Reset selected answer for the next question
                        isAnswered = false; // Enable answering for the next question
                      } else {
                        // If it's the last question, go to results screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              score: score,
                              totalQuestions: widget.numberOfQuestions,
                            ),
                          ),
                        );
                      }
                    });
                  },
                  child: Text('Suivant'),
                ),
            ],
          );
        },
      ),
    );
  }
}
