import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:news_app/models/news/cubit/news_states.dart';
import 'package:news_app/models/news/news_model.dart';
import 'package:news_app/shared/components/constatns/constatns.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  List<NewsModel> _newsList = [];

  List<NewsModel> get sportsNewsList {
    return _newsList.where((news) => news.category == 'sports').toList();
  }

  List<NewsModel> get businessNewsList {
    return _newsList.where((news) => news.category == 'business').toList();
  }

  List<NewsModel> get scienceNewsList {
    return _newsList.where((news) => news.category == 'science').toList();
  }

  Future<void> getSportsNewsData() async {
    DioHelper.getData(
            url: 'v2/top-headlines',
            queryParameters: {'country': 'eg', 'category': 'sports', 'apiKey': kNewsApiKey})
        .then((response) {
      final List<NewsModel> loadedSportsNews = [];
      response.data['articles']
          .map((article) => loadedSportsNews.add(NewsModel(
                id: article['source']['name'],
                title: article['title'],
                imageUrl: article['urlToImage'],
                category: 'sports',
                author: article['author'],
                description: article['description'],
                url: article['url'],
              )))
          .toList();
      _newsList = loadedSportsNews;

      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      emit(NewsGetSportsFailState());
    });
  }
}
