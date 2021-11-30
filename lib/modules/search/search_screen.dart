import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news/news_model.dart';
import 'package:news_app/shared/components/widgets/news_list.dart';
import 'package:news_app/shared/cupit/app_cubit.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<NewsModel> loadedNews = [];

  void getSearchedNews(String value) async {
    if (value.isEmpty) {
      setState(() {
        loadedNews.clear();
      });
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await DioHelper.searchForNews(value);
        setState(() {
          loadedNews.clear();
          response.data['articles']
              .map((article) => loadedNews.add(NewsModel(
                    id: article['source']['name'],
                    title: article['title'],
                    imageUrl: article['urlToImage'],
                    category: 'sports',
                    author: article['author'],
                    description: article['description'],
                    url: article['url'],
                  )))
              .toList();
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong, try again later!'),
          ),
        );
        searchController.clear();
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  var _isLoading = false;
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                getSearchedNews(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: BlocProvider.of<AppCubit>(context).isDark ? Colors.white : Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.deepOrange,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepOrange),
                ),
              ),
            ),
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : NewsList(
                news: loadedNews,
              ));
  }
}
