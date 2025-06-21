import 'package:flutter/material.dart';
import 'package:new10/model/api_model.dart';
import 'package:new10/model/category_model.dart';
import 'package:new10/model/category_tile.dart';
import 'package:new10/model/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:new10/model_screens/deatil_breaking.dart';
import 'package:new10/model_screens/headline_news.dart';
import 'package:new10/model_screens/trending_news.dart';
import 'package:new10/services/fetch_api.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Services _services = Services();
  List<categoryModel> categories = [];

  List<ApiModel> articles = [];
  List<ApiModel> head = [];
  bool _loading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    categories = getcategory();
    getNews();
  }

  getNews() async {
    try {
      FetchApiData tranding = FetchApiData();
      await tranding.getTrendingNews();
      articles = tranding.news;

      FetchApiData headlineclass = FetchApiData();
      await headlineclass.getHeadline();
      head = headlineclass.hl_news;
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          const TextSpan(
            text: "News",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "10",
            style: TextStyle(
                fontSize: 18,
                color: Colors.redAccent[700],
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
        ])),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(left: 6, right: 16),
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                              image: categories[index].categoryImage,
                              categoryName: categories[index].name);
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Breaking News!",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ArticlesScreen(
                                  head: head,
                                );
                              }));
                            },
                            child: const Text(
                              "View all",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: (contex, index, realIndex) {
                        String? title = head[index].title;
                        String? imageurl = head[index].urlToImage;
                        String? url = head[index].url;

                        return headlineTile(
                          title: title,
                          imageurl: imageurl!,
                          url: url!,
                        );
                      },
                      options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(child: buildIndicator()),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending News!",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return BlogTile(
                            desc: articles[index].description!,
                            title: articles[index].title,
                            imageUrl: articles[index].urlToImage!,
                            url: articles[index].url!);
                      },
                      childCount: articles.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: _currentIndex,
        count: 5,
        effect: const SlideEffect(
            dotWidth: 12,
            dotHeight: 12,
            dotColor: Color.fromARGB(255, 24, 23, 23),
            activeDotColor: Color.fromARGB(255, 164, 7, 7)),
      );
}
