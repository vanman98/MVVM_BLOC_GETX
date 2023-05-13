import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import '../constants/constants.dart';

class AppUtils {
  AppUtils._();

  static String appImageCorrect(String url, {base}) {
    if (url.trim().indexOf('http') != 0) {
      return (base ?? 'AppEndpoint.BASE_URL') + url;
    }
    return url;
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void toast(String? message, {Duration? duration}) {
    if (message == null) return;
    showOverlayNotification((context) {
      return SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: AppColors.instance.appBackground,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.instance.rotoboMedium.copyWith(
                          color: AppColors.instance.text, fontSize: 18),
                    ),
                  ),
                  Positioned(
                    top: -Get.width / 2,
                    right: -Get.width,
                    child: Container(
                      width: Get.width * 1.75,
                      height: Get.width * 1.75,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(colors: [
                        AppColors.instance.fromHex('#271733'),
                        AppColors.instance.appBackground
                      ])),
                    ),
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.instance.rotoboMedium
                        .copyWith(color: AppColors.instance.text, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }, duration: duration ?? Duration(milliseconds: 2000));
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
