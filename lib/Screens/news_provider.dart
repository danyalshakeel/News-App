import 'package:flutter/material.dart';
import 'package:new10/model/api_model.dart';
import 'package:new10/services/fetch_api.dart';

class NewsProvider extends ChangeNotifier {
  List<ApiModel> _articles = [];
  List<ApiModel> _headlines = [];
  bool _loading = true;

  List<ApiModel> get articles => _articles;
  List<ApiModel> get headlines => _headlines;
  bool get loading => _loading;

  final FetchApiData _fetchApiData = FetchApiData();

  NewsProvider() {
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      await _fetchApiData.getTrendingNews();
      _articles = _fetchApiData.news;

      await _fetchApiData.getHeadline();
      _headlines = _fetchApiData.hl_news;
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
