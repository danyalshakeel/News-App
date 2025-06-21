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
        print('Requesting: $uri');

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

  Future<bool> _urlExists(String url) async {
  try {
    final resp = await http.head(Uri.parse(url));
    return resp.statusCode == 200;
  } catch (_) {
    return false;
  }
}

Future<void> getTrendingNews() async {
  try {
    final today     = DateTime.now();
    final yesterday = today.subtract(Duration(days: 1));

    final fmt = (DateTime d) =>
        "${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}";

    final uri = Uri.parse(
      "https://newsapi.org/v2/everything"
      "?q=apple"
      "&from=${fmt(yesterday)}"
      "&to=${fmt(today)}"
      "&sortBy=popularity"
      "&apiKey=7cf7dd71b948447ea9986de24aa40d80"
    );

    print('Requesting: $uri');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('NewsAPI returned ${response.statusCode}');
    }

    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    if (jsonData['status'] != 'ok') {
      throw Exception('NewsAPI error: ${jsonData['message'] ?? 'Unknown'}');
    }

    List<ApiModel> fetched = [];
    for (var element in jsonData['articles']) {
      final title       = element['title']       as String?;
      final description = element['description'] as String?;
      final url         = element['url']         as String?;
      final rawImage    = element['urlToImage']  as String?;

      // skip if required bits missing
      if (title == null || description == null || url == null) continue;

      // check that the image actually exists
      final imageUrl = (rawImage != null && await _urlExists(rawImage))
          ? rawImage
          : 'assets/image/Placeholder.jpeg';

      fetched.add(ApiModel(
        title:       title,
        description: description,
        url:         url,
        urlToImage:  imageUrl,
      ));
    }

    // finally, update your list in one go
    news = fetched;
    print('Fetched ${news.length} articles');
  } catch (e, st) {
    print('Error in getTrendingNews(): $e\n$st');
    // Optionally: show a SnackBar / set an error state
  }
}
}
