import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizData? _quizData;
  int _currentIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<void> _loadQuizData() async {
    try {
      final quizData = await ApiService.fetchQuizData();
      setState(() {
        _quizData = quizData;
      });
    } catch (e) {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading quiz: $e')),
      );
    }
  }

  void _selectOption(int index, bool isCorrect) {
    setState(() {
      _isAnswered = true;
      _selectedOptionIndex = index;
      if (isCorrect) {
        _score += 4;
      } else {
        _score -= 1;
      }
    });

    // Move to the next question after feedback
    Future.delayed(const Duration(milliseconds: 700), _moveToNextQuestion);
  }

  void _moveToNextQuestion() {
    if (_currentIndex + 1 < _quizData!.questions.length) {
      setState(() {
        _currentIndex++;
        _isAnswered = false;
        _selectedOptionIndex = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
              score: _score, totalQuestions: _quizData!.questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (_quizData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _quizData!.questions[_currentIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 39, 99),
      appBar: AppBar(
        title: Text(
            'Question ${_currentIndex + 1} / ${_quizData!.questions.length}'),
        backgroundColor: const Color.fromARGB(255, 158, 223, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Question Container
            Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: screenWidth * 0.8, 
                    maxWidth: screenWidth * 0.9, 
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    question.description,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Options List
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = _selectedOptionIndex == index;

              return GestureDetector(
                onTap: _isAnswered
                    ? null
                    : () => _selectOption(index, option.isCorrect),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (option.isCorrect ? Colors.green : Colors.red)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? (option.isCorrect ? Colors.green : Colors.red)
                          : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      option.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                            option.isCorrect
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
