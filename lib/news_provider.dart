import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:translator/translator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsProvider with ChangeNotifier {
  List<Map<String, String>> _news = [];
  bool _isLoading = true;

  List<Map<String, String>> get news => _news;
  bool get isLoading => _isLoading;

  NewsProvider() {
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url = await _getNewsURL();
    if (url != null) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final items = document.findAllElements('item');
        final toLang = 'en'; // Localizations.localeOf(context).languageCode kullanabilirsiniz

        final translatedNews = await Future.wait(items.map((item) async {
          String title = item.findElements('title').single.text;
          String description = item.findElements('description').single.text;

          String translatedTitle = await _translateText(title, toLang);
          String translatedDescription = await _translateText(description, toLang);

          return {
            'title': translatedTitle,
            'description': translatedDescription,
          };
        }).toList());

        _news = translatedNews;
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<String> _translateText(String text, String toLang) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(text, to: toLang);
    return translation.text;
  }

  Future<String?> _getNewsURL() async {
    final snapshot = await FirebaseFirestore.instance.collection('news').doc('news_url').get();
    if (snapshot.exists) {
      return snapshot.data()?['url'];
    }
    return null;
  }
}
