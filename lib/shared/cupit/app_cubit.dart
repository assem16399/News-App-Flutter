import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  var _appCurrentThemeMode = ThemeMode.light;

  ThemeMode get appCurrentThemeMode {
    final themeMode = _appCurrentThemeMode;
    return themeMode;
  }

  void changeAppCurrentThemeMode(ThemeMode mode) {
    _appCurrentThemeMode = mode;
    emit(AppChangeThemeModeState());
    if (mode == ThemeMode.dark) {
      CacheHelper.saveDataInPref(true);
    } else {
      CacheHelper.saveDataInPref();
    }
  }
}
