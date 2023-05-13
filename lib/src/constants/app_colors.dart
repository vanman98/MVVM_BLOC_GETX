import 'package:flutter/material.dart';
import '../../src/utils/utils.dart';

class AppColors {
  AppColors._();

  static final AppColors _instance = AppColors._();

  static AppColors get instance => _instance;

  ///MAIN COLORS
  Color get appBackground => AppPrefs.instance.themeModel == 'dark'
      ? appBackgroundDark
      : appBackgroundLight;

  Color get appBackgroundDark => fromHex('#1C222C');

  Color get appBackgroundLight => fromHex('#1C222C');

  Color get text =>
      AppPrefs.instance.themeModel == 'dark' ? textDark : textLight;

  Color get textDark => fromHex('#A5D3FB');

  Color get textLight => fromHex('#1C222C');

  ///==============

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
