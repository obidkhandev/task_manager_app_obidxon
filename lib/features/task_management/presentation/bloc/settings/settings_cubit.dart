import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/services/settings_service.dart';

class SettingsCubit extends Cubit<Locale?> {
  SettingsCubit(this._service) : super(_service.currentLocale);

  final SettingsService _service;

  void setLocale(Locale? locale) {
    emit(locale);
    _service.setLocaleCode(locale?.languageCode);
  }

  void setLocaleCode(String? code) => setLocale(code == null ? null : Locale(code));
}
