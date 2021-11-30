import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  bool _isDark = false;

  bool get isDark {
    return _isDark;
  }

  void setThemeModeToDark([bool? fromPrefIsDark = null]) {
    if (fromPrefIsDark != null) {
      _isDark = fromPrefIsDark;
    } else {
      _isDark = !_isDark;
    }
    emit(AppChangeThemeModeState());

    CacheHelper.saveDataInPref(_isDark);
  }
}
