import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_cubit.dart';
import '../generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.settings)),
      body: BlocBuilder<SettingsCubit, Locale?>(
        builder: (context, locale) {
          final code = locale?.languageCode;
          void set(String? v) => context.read<SettingsCubit>().setLocaleCode(v);
          return ListView(
            children: [
              ListTile(title: Text(s.language), dense: true),
              RadioListTile<String?>(
                value: null,
                groupValue: code,
                onChanged: set,
                title: Text(s.systemDefault),
              ),
              const Divider(height: 0),
              RadioListTile<String?>(
                value: 'en',
                groupValue: code,
                onChanged: set,
                title: Text(s.english),
              ),
              RadioListTile<String?>(
                value: 'ru',
                groupValue: code,
                onChanged: set,
                title: Text(s.russian),
              ),
              RadioListTile<String?>(
                value: 'uz',
                groupValue: code,
                onChanged: set,
                title: Text(s.uzbek),
              ),
            ],
          );
        },
      ),
    );
  }
}

