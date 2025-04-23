import 'dart:convert';

import 'package:new10/model/api_model.dart';
import 'package:http/http.dart' as http;

class FetchApiData {
  List<ApiModel> category = [];
  List<ApiModel> hl_news = [];
  List<ApiModel> news = [];

  Future<void> getCategoryNews(String name) async {
    final uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?category=$name&apiKey=7cf7dd71b948447ea9986de24aa40d80");
    print(uri);
    final response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          print("UrlToImage and description both not null");
        }
        ApiModel articleModel = ApiModel(
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
        );
        print("Mapped and add to the List");
        news.add(articleModel);
        print(category.length);
      });
    }
  }

  Future<void> getHeadline() async {
    final uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=7cf7dd71b948447ea9986de24aa40d80");
    //  print('Requesting: $uri');

    final response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ApiModel headlineModel = ApiModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
          );
          hl_news.add(headlineModel);
        }
      });
    }
  }

  Future<void> getTrendingNews() async {
    final uri = Uri.parse(
        "https://newsapi.org/v2/everything?q=apple&from=2025-04-22&to=2025-04-23&sortBy=popularity&apiKey=7cf7dd71b948447ea9986de24aa40d80");
    //  print('Requesting: $uri');

    final response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ApiModel articleModel = ApiModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
