import 'package:flutter/material.dart';

import 'app_colors.dart';

class _AppFontSizes {
  static const double fontTextTitle = 22.0;
  static const double fontTextBig = 22.0;
  static const double fontText = 16.0;
  static const double fontTextSmall = 12.0;
  static const double fontExtraSmall = 8.0;
  static const double fontTextExtraBig = 31;
  static const double fontErrorText = 14;
}

class AppTextStyles {
  AppTextStyles._();

  static final AppTextStyles _instance = AppTextStyles._();

  static AppTextStyles get instance => _instance;

  String get fontFamilyRubik => 'Rubik';

  TextStyle get rubikMedium => TextStyle(
      height: 1.15,
      fontFamily: fontFamilyRubik,
      color: AppColors.instance.text,
      fontWeight: FontWeight.w500,
      fontSize: _AppFontSizes.fontText);

  TextStyle get rubikRegular =>
      rubikMedium.copyWith(fontWeight: FontWeight.w300);

  TextStyle get rubikBold => rubikMedium.copyWith(fontWeight: FontWeight.bold);

  TextStyle get rubikBoldBlack =>
      rubikMedium.copyWith(fontWeight: FontWeight.w900);

  String get fontFamilyRoboto => 'Roboto';

  TextStyle get rotoboMedium => TextStyle(
      height: 1.15,
      fontFamily: fontFamilyRoboto,
      color: AppColors.instance.text,
      fontWeight: FontWeight.w500,
      fontSize: _AppFontSizes.fontText);

  TextStyle get rotoboRegular =>
      rotoboMedium.copyWith(fontWeight: FontWeight.w300);

  TextStyle get rotoboBold =>
      rotoboMedium.copyWith(fontWeight: FontWeight.bold);

  TextStyle get rotoboBoldBlack =>
      rotoboMedium.copyWith(fontWeight: FontWeight.w900);
}
