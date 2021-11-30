import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cupit/app_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
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
      body: ListView.builder(
        itemBuilder: (context, index) => Container(),
        itemCount: 0,
      ),
    );
  }
}
