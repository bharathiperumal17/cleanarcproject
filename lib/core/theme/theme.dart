import 'package:cleanarcproject/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 3),
      borderRadius: BorderRadius.circular(10));
  static final darkThemeMode = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
      ),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      chipTheme: const ChipThemeData(
        side: BorderSide.none,
        color: MaterialStatePropertyAll(AppPallete.backgroundColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: _border(),
          focusedBorder: _border(AppPallete.gradient2),
          errorBorder: _border(AppPallete.errorColor)

          // errorBorder: _border.copyWith(borderSide: const BorderSide(color: AppPallete.errorColor))
          ));
}
