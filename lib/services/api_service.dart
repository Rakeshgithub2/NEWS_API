import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchNews() async {
    try {
     final response = await http.get(Uri.parse('https://cors-anywhere.herokuapp.com/https://your-api.com/news'));

      if (response.statusCode != 200) {
        print("Failed to load news: ${response.statusCode}");
        return [];
      }

      final data = jsonDecode(response.body);
      print("API Response: $data");

      if (data == null || data['articles'] == null) {
        print("Error: No articles found in the API response.");
        return [];
      }

      List<dynamic> articles = data['articles'];
      for (var article in articles) {
        if (article != null) {
          article['imageUrl'] = fixUrl(article['imageUrl']);
        } else {
          print("Warning: Found a null article.");
        }
      }

      return articles;
    } catch (e) {
      print("Error fetching news: $e");
      return [];
    }
  }

  String fixUrl(String? url) {
    if (url == null) {
      print("Warning: Null imageUrl found.");
      return "https://via.placeholder.com/150"; // Placeholder image
    }
    if (url.startsWith("http://")) {
      print("Fixing URL: $url");
      return url.replaceFirst("http://", "https://");
    }
    return url;
  }
}
