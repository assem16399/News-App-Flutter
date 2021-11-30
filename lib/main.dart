import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news/cubit/news_cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/news_layout.dart';
import 'shared/components/constants/bloc_observer.dart';
import 'shared/cupit/app_cubit.dart';
import 'shared/cupit/app_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  final mode = CacheHelper.getSavedDataInPref();
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        sharedPrefIsDark: mode,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? sharedPrefIsDark;
  const MyApp({Key? key, required this.sharedPrefIsDark}) : super(key: key);
  // This widget is the root of your application.

  // ThemeMode? getThemeMode(bool? cubitThemeModeIsDark, bool? sharedPrefThemeModeIsDark) {
  //   if (cubitThemeModeIsDark == null && sharedPrefThemeModeIsDark == null) {
  //     return ThemeMode.system;
  //   }
  //   if (cubitThemeModeIsDark == true) {
  //     return ThemeMode.dark;
  //   } else if (cubitThemeModeIsDark == false) {
  //     return ThemeMode.light;
  //   } else if (cubitThemeModeIsDark == null) {
  //     if (sharedPrefThemeModeIsDark == true) {
  //       return ThemeMode.dark;
  //     } else {
  //       return ThemeMode.light;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..setThemeModeToDark(sharedPrefIsDark)),
        BlocProvider(create: (context) => NewsCubit()..getSportsNewsData())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, appState) {},
        builder: (context, appState) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: BlocProvider.of<AppCubit>(context).isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color(0XFF333739),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
                  .copyWith(secondary: const Color(0XFF333739), onSecondary: Colors.white),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0XFF333739),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Color(0XFF333739),
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color(0XFF333739),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                showSelectedLabels: true,
              ),
              textTheme: const TextTheme(
                  bodyText1:
                      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  bodyText2: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  )),
            ),
            theme: ThemeData(
              textTheme: const TextTheme(
                  bodyText1:
                      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                  bodyText2: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  )),
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
          );
        },
      ),
    );
  }
}
