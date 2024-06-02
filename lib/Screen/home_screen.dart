import 'package:flutter/material.dart';
import 'package:tugasakhir_sanbercode/Screen/category_news.dart';
import 'package:tugasakhir_sanbercode/Screen/news_detail.dart'; 
import 'package:tugasakhir_sanbercode/Screen/profile_screen.dart';
import 'package:tugasakhir_sanbercode/Services/services.dart';
import 'package:tugasakhir_sanbercode/model/category_data.dart';
import '../model/new_model.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  int _selectedIndex = 0;
  List<NewsModel> articles = [];
  List<CategoryModel> categories = [];
  bool isLoading = true;

  void getNews() async {
    NewsApi newsApi = NewsApi();
    await newsApi.getNews();
    setState(() {
      articles = newsApi.dataStore;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectedCategoryNews(
                                  category: category.categoryName!,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: Text(
                                category.categoryName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetail(newsModel: article), // Ganti NewsDetail dengan NewsDetailPage
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article.urlToImage!,
                                  height: 250,
                                  width: 400,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                article.title!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Divider(thickness: 2),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
