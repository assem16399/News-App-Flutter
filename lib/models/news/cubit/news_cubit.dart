import 'package:bloc/bloc.dart';
import 'package:news_app/models/news/cubit/news_states.dart';
import 'package:news_app/models/news/news_model.dart';
import 'package:news_app/shared/components/constants/constants.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  List<NewsModel> _sportsNewsList = [];
  List<NewsModel> _scienceNewsList = [];
  List<NewsModel> _businessNewsList = [];

  List<NewsModel> get sportsNewsList {
    return [..._sportsNewsList];
  }

  List<NewsModel> get businessNewsList {
    return [..._businessNewsList];
  }

  List<NewsModel> get scienceNewsList {
    return [..._scienceNewsList];
  }

  Future<void> getSportsNewsData() async {
    if (_sportsNewsList.isEmpty) {
      emit(NewsLoadingState());
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
        _sportsNewsList = loadedSportsNews;

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsFailState());
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  Future<void> getBusinessNewsData() async {
    if (_businessNewsList.isEmpty) {
      emit(NewsLoadingState());

      DioHelper.getData(
              url: 'v2/top-headlines',
              queryParameters: {'country': 'eg', 'category': 'business', 'apiKey': kNewsApiKey})
          .then((response) {
        final List<NewsModel> loadedBusinessNews = [];
        response.data['articles']
            .map((article) => loadedBusinessNews.add(NewsModel(
                  id: article['source']['name'],
                  title: article['title'],
                  imageUrl: article['urlToImage'],
                  category: 'business',
                  author: article['author'],
                  description: article['description'],
                  url: article['url'],
                )))
            .toList();
        _businessNewsList = loadedBusinessNews;

        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetBusinessFailState());
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  Future<void> getScienceNewsData() async {
    if (_scienceNewsList.isEmpty) {
      emit(NewsLoadingState());

      DioHelper.getData(
              url: 'v2/top-headlines',
              queryParameters: {'country': 'eg', 'category': 'science', 'apiKey': kNewsApiKey})
          .then((response) {
        final List<NewsModel> loadedSciencesNews = [];
        response.data['articles']
            .map((article) => loadedSciencesNews.add(NewsModel(
                  id: article['source']['name'],
                  title: article['title'],
                  imageUrl: article['urlToImage'],
                  category: 'science',
                  author: article['author'],
                  description: article['description'],
                  url: article['url'],
                )))
            .toList();
        _scienceNewsList = loadedSciencesNews;

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceFailState());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
