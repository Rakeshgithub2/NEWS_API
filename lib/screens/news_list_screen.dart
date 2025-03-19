import 'package:flutter/material.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/widgets/news_tile.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              newsProvider.fetchNews();
            },
          ),
        ],
      ),
      body: newsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : newsProvider.hasError
              ? const Center(child: Text('Failed to fetch news'))
              : RefreshIndicator(
                  onRefresh: () async {
                    await newsProvider.fetchNews();
                  },
                  child: ListView.builder(
                    itemCount: newsProvider.newsList.length,
                    itemBuilder: (context, index) {
                      final article = newsProvider.newsList[index];
                      return NewsTile(article: article);
                    },
                  ),
                ),
    );
  }
}
