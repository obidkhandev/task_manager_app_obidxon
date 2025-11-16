import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'features/task_management/presentation/bloc/task/task_bloc.dart';
import 'bloc/settings_cubit.dart';
import 'screens/task_list_screen.dart';
import 'services/task_repository.dart';
import 'services/settings_service.dart';
import 'injection_container.dart' as di;
import 'theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = di.sl<TaskRepository>();
    return RepositoryProvider.value(
      value: repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => TaskBloc(
              getAllTasks: di.sl(),
              addTask: di.sl(),
              updateTask: di.sl(),
              deleteTask: di.sl(),
            ),
          ),
          BlocProvider(create: (_) => SettingsCubit(di.sl<SettingsService>())),
        ],
        child: BlocBuilder<SettingsCubit, Locale?>(
          builder: (context, locale) => MaterialApp(
            onGenerateTitle: (context) => S.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              useMaterial3: true,
            ),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: locale,
            home: const TaskListScreen(),
          ),
        ),
      ),
    );
  }
}
