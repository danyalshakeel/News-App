import 'package:flutter/material.dart';
import 'package:new10/model_screens/category_detail_page.dart';

class CategoryTile extends StatelessWidget {
  final String? image;
  final String? categoryName;

  const CategoryTile({
    Key? key,
    this.image,
    this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (categoryName != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailPage(src: categoryName!),
            ),
          );
        } else {
          // Handle the case where categoryName is null, e.g., show a toast
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category not found!')),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image ?? 'assets/images/news.jpg', // Fallback image
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Center(
                child: Text(
                  categoryName ?? 'Unknown Category', // Fallback text
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
