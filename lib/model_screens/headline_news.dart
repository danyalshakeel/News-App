import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class headlineTile extends StatelessWidget {
  headlineTile({
    super.key,
    required this.title,
    required this.imageurl,
    required this.url,
  });
  String title, imageurl, url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        // Launch the URL inside the app
        if (!await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView, // Open URL inside the app
        )) {
          throw 'Could not launch $url';
        }
        // Navigator.push(context, MaterialPageRoute(builder: (_) {
        //   return HeadlineWebView(
        //     url: url,
        //   );
        // }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: CachedNetworkImage(
                  imageUrl: imageurl,
                  height: 250,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                )),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 190),
              decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(11.6),
                    bottomRight: Radius.circular(11),
                  )),
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
