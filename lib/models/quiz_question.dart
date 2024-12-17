class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({required this.question, required this.options, required this.correctAnswer});

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    var optionsFromJson = List<String>.from(json['incorrect_answers']);
    optionsFromJson.add(json['correct_answer']);
    optionsFromJson.shuffle(); // Mélanger les options

    return QuizQuestion(
      question: json['question'],
      options: optionsFromJson,
      correctAnswer: json['correct_answer'],
    );
  }
}
