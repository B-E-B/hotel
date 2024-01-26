import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData defaults() {
    const mainFontFamily = 'SfProDisplay';

    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.titleColor,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 30,
          ),
          titleMedium: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.titleColor,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 22,
          ),
          titleSmall: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.titleColor,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 18,
          ),
          bodyLarge: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.infoColor,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.infoColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.infoColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
          ),
          labelLarge: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.greyText,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
          labelMedium: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.greyText,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
          labelSmall: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.blueText,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 14,
          )),
    );
  }
}
