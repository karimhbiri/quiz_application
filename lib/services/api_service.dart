import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_application/models/quiz_question.dart';

class ApiService {
  final String _baseUrl = "https://opentdb.com/api.php";

  Future<List<QuizQuestion>> fetchQuestions(String category, String difficulty, int amount) async {
    final response = await http.get(Uri.parse(
      '$_baseUrl?amount=$amount&category=$category&difficulty=$difficulty&type=multiple',
    ));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return List<QuizQuestion>.from(data['results'].map((x) => QuizQuestion.fromJson(x)));
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://opentdb.com/api_category.php'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['trivia_categories']);
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
