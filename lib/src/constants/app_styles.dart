import 'package:flutter/material.dart';
import 'constants.dart';

class AppStyles {
  AppStyles._();

  static final AppStyles _instance = AppStyles._();

  static AppStyles get instance => _instance;

  static Gradient get gradient => LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            AppColors.instance.fromHex('#1C222C'),
            AppColors.instance.fromHex('#343F5C')
          ]);
}
