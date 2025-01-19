import 'package:dio/dio.dart';

import '../models/quiz_model.dart';


class ApiService {
  static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  static Future<QuizData> fetchQuizData() async {
    try {
      final dio = Dio();
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        return QuizData.fromJson(response.data);
      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
