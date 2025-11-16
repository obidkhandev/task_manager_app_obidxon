import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:task_manager/generated/l10n.dart';
import 'package:task_manager/features/task_management/presentation/widgets/top_progress_card.dart';

void main() {
  testWidgets('TopProgressCard shows computed percent and localized title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const Scaffold(body: TopProgressCard(percent: 0.42)),
      ),
    );
    await tester.pumpAndSettle();

    // 0.42 => 42%
    expect(find.text('42%'), findsOneWidget);
    expect(find.text("${S.current.yourTodaysTask} ${S.current.almostDone}"), findsOneWidget);
  });
}
