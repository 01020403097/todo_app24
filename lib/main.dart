import 'package:flutter/material.dart';
import 'package:todo_task/style/app_theme.dart';
import 'package:todo_task/tabs/settings/settings_tab.dart';
import 'package:todo_task/tabs/tasks/tasks_tab.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName:(_)=>const HomeScreen(),
        TasksTab.routeName:(_)=>const TasksTab(),
        SettingsTab.routeName:(_)=>const SettingsTab(),
      },
      initialRoute: HomeScreen.routeName,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,

    );
  }
}

