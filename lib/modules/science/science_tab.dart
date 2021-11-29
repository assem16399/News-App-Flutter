import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news/cubit/news_cubit.dart';
import 'package:news_app/models/news/cubit/news_states.dart';
import 'package:news_app/shared/components/widgets/news_list.dart';

class ScienceTab extends StatelessWidget {
  const ScienceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsData = BlocProvider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, newsState) {},
        builder: (context, newsState) {
          final scienceNews = newsData.scienceNewsList;
          if (scienceNews.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (newsState is NewsGetSportsFailState) {
            Future.delayed(Duration.zero).then((_) =>
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('error'))));
            return const SizedBox();
          } else {
            return NewsList(
              news: scienceNews,
            );
          }
        });
  }
}
