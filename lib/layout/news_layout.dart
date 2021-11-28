import 'package:flutter/material.dart';
import 'package:news_app/modules/business/business_tab.dart';
import 'package:news_app/modules/science/science_tab.dart';
import 'package:news_app/modules/sports/sports_tab.dart';

class NewsLayout extends StatefulWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  _NewsLayoutState createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  final tabs = <Widget>[
    const SportsTab(),
    const BusinessTab(),
    const ScienceTab(),
  ];
  final appBarTitles = <String>[
    'Sports News',
    'Business News',
    'Science News',
  ];
  var currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[currentPageIndex]),
      ),
      body: tabs[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: Colors.deepOrange,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
        ],
      ),
    );
  }
}
