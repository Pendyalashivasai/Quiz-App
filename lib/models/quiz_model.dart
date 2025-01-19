class QuizData {
  final String title;
  final String description;
  final List<Question> questions;

  QuizData({required this.title, required this.description, required this.questions});

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }
}

class Question {
  final String description;
  final List<Option> options;

  Question({required this.description, required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      description: json['description'] ?? '',
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }
}

class Option {
  final String description;
  final bool isCorrect;

  Option({required this.description, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      description: json['description'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
