import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/strings.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: AppColors.primary,
      hintColor: AppColors.hint,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      fontFamily: Strings.fontFamily,
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
      ));
}
