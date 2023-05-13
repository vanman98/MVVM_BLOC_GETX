import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppPrefs {
  AppPrefs._();

  static final AppPrefs _instance = AppPrefs._();

  static AppPrefs get instance => _instance;

  late Box _box;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  initListener() async {
    if (!kIsWeb) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      Hive..init(appDocDirectory.path);
    }
    _box = await Hive.openBox('AppPref');
  }

  Stream watch(key) => _box.watch(key: key);

  void clear() {
    _box.delete('accessToken');
    _box.delete('themeModel');
  }

  set themeModel(String? value) => _box.put('themeModel', value);

  String? get themeModel => _box.get('themeModel');

  set languageCode(String? value) => _box.put('languageCode', value);

  String? get languageCode => _box.get('languageCode');

  final String _accessToken = 'accessToken';
  final String _refreshToken = 'refreshToken';
  Future save(String key, String? value) =>
      _secureStorage.write(key: key, value: value);

  dynamic getNormalToken() async {
    var result = _secureStorage.read(key: _accessToken);
    // if (result != null) {
    //   DateTime? expiryDate = Jwt.getExpiryDate(result.toString());
    //   if (expiryDate != null &&
    //       expiryDate.millisecondsSinceEpoch <
    //           DateTime.now().millisecondsSinceEpoch) {
    //     String refresh = _secureStorage.read(key: refreshToken).toString();
    //     var newToken = await _repository.refreshProToken(refresh);
    //     if (newToken?.accessToken != null) {
    //       result = newToken!.accessToken;
    //       _secureStorage.write(key:accessToken,value result.toString());
    //     }
    //   }
    // }
    return result;
  }
}
