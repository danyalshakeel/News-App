import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BlogTile extends StatelessWidget {
  BlogTile(
      {super.key,
      required this.desc,
      required this.title,
      required this.imageUrl,
      required this.url});
  String imageUrl, title, desc, url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(url));
        print("URL lunched");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(

                      borderRadius: BorderRadius.circular(20),
                      child: imageUrl=='assets/images/Placeholder.jpeg'?Image.asset(
                        imageUrl,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ):
                      Image.network(
                        imageUrl,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        desc,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
