import 'package:bloc/bloc.dart';
import 'package:cricklo/core/utils/constants/theme.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      ColorsConstants.isDarkMode = true;
      emit(ThemeMode.dark);
    } else {
      ColorsConstants.isDarkMode = false;
      emit(ThemeMode.light);
    }
  }

  void setTheme(ThemeMode mode) {
    ColorsConstants.isDarkMode = mode == ThemeMode.dark;
    emit(mode);
  }
}
