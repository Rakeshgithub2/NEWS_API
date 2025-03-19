import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsArticle> _newsList = [];
  bool _isLoading = false;
  bool _hasError = false;

  List<NewsArticle> get newsList => _newsList;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchNews() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _newsList = await NewsService().fetchNews();
    } catch (e) {
      _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
