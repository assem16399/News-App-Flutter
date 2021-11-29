import 'package:flutter/material.dart';
import 'package:news_app/models/news/news_model.dart';

import 'news_list_item.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.news}) : super(key: key);
  final List<NewsModel> news;
  @override
  Widget build(BuildContext context) {
    print('list rebuilds...');

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) => NewsListItem(
        imageUrl: news[index].imageUrl,
        title: news[index].title,
        description: news[index].description,
      ),
    );
  }
}
