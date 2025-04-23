import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new10/model/api_model.dart';
import 'package:new10/services/fetch_api.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryDetailPage extends StatefulWidget {
  CategoryDetailPage({super.key, required this.src});

  final String src;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<ApiModel> head = [];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    try {
      FetchApiData categoryNews = FetchApiData();

      await categoryNews.getCategoryNews(widget.src);

      setState(() {
        head = categoryNews.news;
      });
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: Text(
          widget.src.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: head.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFF8F8F8),
                  ),
                  height: MediaQuery.of(context).size.height / 2.2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: head[index].urlToImage != null &&
                                  head[index].urlToImage!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: head[index].urlToImage!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/image/news.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  "assets/image/news.jpg",
                                  width:
                                      MediaQuery.of(context).size.height / 2.3,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        head[index].title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        head[index].description ?? 'No description available.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.open_in_new,
                              color: Colors.blueAccent),
                          TextButton(
                            onPressed: () {
                              if (head[index].url != null) {
                                launchUrl(Uri.parse(head[index].url!));
                              }
                            },
                            child: const Text(
                              "Read More",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
