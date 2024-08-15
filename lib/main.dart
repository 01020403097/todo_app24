import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/providers/setting_prov.dart';
import 'package:todo_task/providers/tasks_providers.dart';
import 'package:todo_task/style/app_theme.dart';
import 'package:todo_task/tabs/settings/settings_tab.dart';
import 'package:todo_task/tabs/tasks/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingProvider = SettingProvider();
  await settingProvider.loadPreferences();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TasksProviders()..getTasks(),
        ),
        ChangeNotifierProvider<SettingProvider>.value(value: settingProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        TasksTab.routeName: (_) => const TasksTab(),
        SettingsTab.routeName: (_) => const SettingsTab(),
      },
      initialRoute: HomeScreen.routeName,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: settingProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingProvider.language),
    );
  }
}
