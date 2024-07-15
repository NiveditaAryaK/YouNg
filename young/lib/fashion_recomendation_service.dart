import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'message.dart';  // Import the Message class

Future<String> getFashionRecommendation(List<Message> messages) async {
  final url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${dotenv.env['GEMINI_API_KEY']}';

  // Build the conversation history as part of the prompt
  final history = messages.map((msg) => msg.isUser ? 'User: ${msg.text}' : 'Bot: ${msg.text}').join('\n');

  final prompt = '''
You are a fashion recommendation system. Your task is to provide fashion advice based on the user's input and help them find suitable outfits or styles. Do not respond to questions unrelated to fashion. Keep track of the user's preferences and offer fashion tips accordingly.

Here is the conversation history:
$history

User's current request: "${messages.last.text}"

Please provide a fashion recommendation based on the user's request.
''';

  final body = jsonEncode({
    'contents': [
      {
        'parts': [
          {
            'text': prompt,
          },
        ],
      },
    ],
  });

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response Data: $data'); // Log the response data for debugging

      if (data is Map && data.containsKey('candidates')) {
        final candidates = data['candidates'];
        if (candidates is List && candidates.isNotEmpty) {
          final firstCandidate = candidates[0];
          if (firstCandidate is Map && firstCandidate.containsKey('content')) {
            final content = firstCandidate['content'];
            if (content is Map && content.containsKey('parts')) {
              final parts = content['parts'];
              if (parts is List && parts.isNotEmpty) {
                final firstPart = parts[0];
                if (firstPart is Map && firstPart.containsKey('text')) {
                  return firstPart['text'] ?? 'No recommendation found.';
                } else {
                  return 'No text found in the first part.';
                }
              } else {
                return 'No parts found in the content.';
              }
            } else {
              return 'No parts key found in the content.';
            }
          } else {
            return 'No content key found in the first candidate.';
          }
        } else {
          return 'No candidates found in the response.';
        }
      } else {
        return 'Invalid or empty response data.';
      }
    } else {
      throw Exception('Failed to load recommendations: ${response.body}');
    }
  } catch (error) {
    print('Error occurred: $error');
    return 'Failed to get fashion recommendations. Please try again later.';
  }
}
