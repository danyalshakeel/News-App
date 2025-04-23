import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new10/model/api_model.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ArticlesScreen extends StatelessWidget {
  ArticlesScreen({
    super.key,
    required this.head,
  });
  List<ApiModel> head = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text.rich(TextSpan(children: [
          const TextSpan(
            text: "Breaking ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "News",
            style: TextStyle(
                fontSize: 24,
                color: Colors.redAccent[700],
                fontWeight: FontWeight.bold),
          ),
        ])),
        elevation: 3,
      ),
      body: Container(
          child: ListView.builder(
        itemCount: head.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            margin: EdgeInsets.symmetric(horizontal: 8),
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
                    color: const Color(0xFFF8F8F8), // Light background color
                  ),
                  height: MediaQuery.of(context).size.height / 2.1,
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
                          child: CachedNetworkImage(
                            imageUrl: head[index].urlToImage!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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
                        head[index].description!,
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
                              launchUrl(Uri.parse(head[index].url!));
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
      )),
    );
  }
}
