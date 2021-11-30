import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news/cubit/news_cubit.dart';
import 'package:news_app/modules/business/business_tab.dart';
import 'package:news_app/modules/science/science_tab.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/modules/sports/sports_tab.dart';
import 'package:news_app/shared/cupit/app_cubit.dart';

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
    final appData = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[currentPageIndex]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              appData.setThemeModeToDark();
            },
            icon: const Icon(Icons.brightness_4_outlined),
          )
        ],
      ),
      body: tabs[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        ],
      ),
    );
  }
}
