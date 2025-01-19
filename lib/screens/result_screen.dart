import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({Key? key, required this.score, required this.totalQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percentage = (score / (totalQuestions * 4)) * 100; // Assuming 4 points per correct answer
    final String resultMessage = percentage >= 80
        ? 'Excellent! 🎉'
        : percentage >= 50
            ? 'Good Job! 😊'
            : 'Keep Trying! 💪';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 4, 39, 99)
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Confetti/Animation
                const Icon(Icons.emoji_events, size: 100, color: Colors.yellow),
                const SizedBox(height: 20),
                // Result Message
                Text(
                  resultMessage,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Score Summary
                Text(
                  'Your Score: $score / ${totalQuestions * 4}',
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'You answered ${score ~/ 4} out of $totalQuestions questions correctly!',
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 30),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Retry Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back to QuizScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Retry Quiz', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(width: 20),
                    // Share Button
                    ElevatedButton(
                      onPressed: () {
                        // // Implement sharing functionality here
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Share feature coming soon!')),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Share Results', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
