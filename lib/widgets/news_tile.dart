import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/screens/news_detail_screen.dart';

class NewsTile extends StatelessWidget {
  final NewsArticle article;

  const NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article.imageUrl.isNotEmpty
          ? Image.network(article.imageUrl, width: 100, fit: BoxFit.cover)
          : const Icon(Icons.image_not_supported),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
    builder: (context) => NewsDetailScreen(articleUrl: article.url)),

        );
      },
    );
  }
}
