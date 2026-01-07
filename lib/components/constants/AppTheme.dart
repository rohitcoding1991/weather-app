
import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AppFonts.dart';
import 'TextStyles.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    textTheme: const TextTheme(),
    fontFamily: Family.regular,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    colorScheme: const ColorScheme.light(
      background: AppColors.primaryColor,

    ),
    primaryColor: AppColors.primaryGreen,
    inputDecorationTheme: EditTextTheme.editTextTheme,
    floatingActionButtonTheme: _floatingButtonTheme,
    checkboxTheme: _checkboxThemeData
  );

  static final ThemeData dark = ThemeData(
    textTheme: const TextTheme(),
    fontFamily: Family.regular,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    colorScheme: const ColorScheme.light(
      background: AppColors.primaryColor,
    ),
    primaryColor: AppColors.primaryGreen,
    inputDecorationTheme: EditTextTheme.editTextTheme,
      floatingActionButtonTheme: _floatingButtonTheme,
    checkboxTheme: _checkboxThemeData
  );


  static FloatingActionButtonThemeData get _floatingButtonTheme => FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryBackground,
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppFonts.s40)),
  );


  static CheckboxThemeData get _checkboxThemeData => CheckboxThemeData(
    fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.primaryColor;
      }
      return AppColors.transparent;
    },
    ),
    side: const BorderSide(
      color: Colors.grey,
      width: 2.0,
    )
  );
}


class EditTextTheme {
  static InputDecorationTheme get editTextTheme => InputDecorationTheme(
    focusColor: AppColors.primaryColor,
    disabledBorder: disableBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: setErrorBorder,
    labelStyle: TextStyles.regular14Black,
    outlineBorder: outlinedBorder,
    focusedBorder: focusedBorder,
    enabledBorder: enabledBorder,
  );

  static InputBorder get disableBorder => InputBorder.none;

  static BorderSide get outlinedBorder => BorderSide.none;

  static InputBorder get focusedBorder => setBorder;

  static InputBorder get enabledBorder => setBorder;

  static InputBorder get errorBorder => setErrorBorder;

  static InputBorder get setBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppFonts.s10),
      borderSide: const BorderSide(color: AppColors.grey20, width: 2));

  static InputBorder get setErrorBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppFonts.s10),
      borderSide: const BorderSide(color: AppColors.red, width: 2));
}


