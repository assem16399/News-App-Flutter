import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news/cubit/news_cubit.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/news_layout.dart';
import 'shared/components/constants/bloc_observer.dart';

void main() {
  DioHelper.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getSportsNewsData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
              .copyWith(onSecondary: Colors.white),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            showSelectedLabels: true,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const NewsLayout(),
      ),
    );
  }
}
