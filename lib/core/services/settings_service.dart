import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsService {
  static const String settingsBoxName = 'settingsBox';
  static const String keyLocale = 'locale';

  Future<void> init() async {
    // Hive.initFlutter() is already called by HiveTaskService; but calling again is safe.
    if (!Hive.isBoxOpen(settingsBoxName)) {
      await Hive.openBox(settingsBoxName);
    }
  }

  Box get _box => Hive.box(settingsBoxName);

  String? get localeCode => _box.get(keyLocale) as String?;

  Future<void> setLocaleCode(String? code) async {
    if (code == null) {
      await _box.delete(keyLocale);
    } else {
      await _box.put(keyLocale, code);
    }
  }

  Locale? get currentLocale => localeCode == null ? null : Locale(localeCode!);
}

