import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> findFashionMismatch(List<String> imageUrls) async {
  final url = 'https://your-mismatch-api-endpoint.com/findMismatch';  // Replace with your mismatch API endpoint

  // Build the request body with image URLs
  final body = jsonEncode({
    'imageUrls': imageUrls,
  });

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // Process the response
    return data['result'] ?? 'No mismatch result found.';
  } else {
    throw Exception('Failed to find mismatches: ${response.body}');
  }
}
