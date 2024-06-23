import 'dart:convert';
import 'package:http/http.dart' as http;


class GeminiModel {
  final String apiKey;

  GeminiModel({required this.apiKey});

  Future<GeminiResponse> generateResponse(String message) async {
    // Replace the following lines with your actual API call logic
    final response = await http.post(
      Uri.parse('https://api.example.com/generate-response'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GeminiResponse(text: data['response']);
    } else {
      throw Exception('Failed to generate response');
    }
  }
}

class GeminiResponse {
  final String text;

  GeminiResponse({required this.text});
}
