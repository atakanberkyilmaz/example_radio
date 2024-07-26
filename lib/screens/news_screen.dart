import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:example_radio/news_provider.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: newsProvider.news.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(newsProvider.news[index]['title']!),
                  subtitle: Text(newsProvider.news[index]['description']!),
                );
              },
            );
          }
        },
      ),
    );
  }
}
