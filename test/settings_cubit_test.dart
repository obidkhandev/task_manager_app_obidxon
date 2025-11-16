import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/core/services/settings_service.dart';

import 'package:task_manager/features/task_management/presentation/bloc/settings/settings_cubit.dart';

class _MockSettingsService extends Mock implements SettingsService {}

void main() {
  late _MockSettingsService service;
  late SettingsCubit cubit;

  setUp(() {
    service = _MockSettingsService();
    when(() => service.currentLocale).thenReturn(null);
    cubit = SettingsCubit(service);
  });

  tearDown(() => cubit.close());

  test('initial state matches service currentLocale', () {
    expect(cubit.state, isNull);
  });

  test('setLocale emits and persists locale code', () async {
    when(() => service.setLocaleCode(any())).thenAnswer((_) async {});
    final l = const Locale('ru');
    cubit.setLocale(l);

    await expectLater(cubit.stream, emitsInOrder([l]));
    verify(() => service.setLocaleCode('ru')).called(1);
  });

  test('setLocaleCode(null) clears saved locale and emits null', () async {
    when(() => service.setLocaleCode(any())).thenAnswer((_) async {});
    cubit.setLocaleCode(null);

    await expectLater(cubit.stream, emitsInOrder([isNull]));
    verify(() => service.setLocaleCode(null)).called(1);
  });
}

