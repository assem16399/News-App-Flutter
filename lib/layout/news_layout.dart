import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news/cubit/news_cubit.dart';
import 'package:news_app/modules/business/business_tab.dart';
import 'package:news_app/modules/science/science_tab.dart';
import 'package:news_app/modules/settings/settings_tab.dart';
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
    const SettingsTab(),
  ];
  final appBarTitles = <String>['Sports News', 'Business News', 'Science News', 'Settings'];
  var currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[currentPageIndex]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: tabs[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        //selectedItemColor: Colors.deepOrange,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
          if (index == 1) {
            BlocProvider.of<NewsCubit>(context).getBusinessNewsData();
          } else if (index == 2) {
            BlocProvider.of<NewsCubit>(context).getScienceNewsData();
          }
        },
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
