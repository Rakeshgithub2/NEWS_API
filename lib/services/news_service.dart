import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class NewsService {
  final String apiKey = '8ca4138105d14c07b0679eb7955c121e';  // Replace with your API Key

  Future<List<NewsArticle>> fetchNews() async {
    final url = Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        return articles.map((e) => NewsArticle.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news');
    }
  }
}
