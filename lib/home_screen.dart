import 'package:flutter/material.dart';
import 'package:todo_task/tabs/settings/settings_tab.dart';
import 'package:todo_task/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:todo_task/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [const TasksTab(), const SettingsTab()];

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
            context: context, builder: (context) => AddTaskBottomSheet(),);
        },
        child:  Icon(
          Icons.add,
          size: height*0.032,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomAppBar(
        shape:  CircularNotchedRectangle(),
        notchMargin: height*0.01,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          items:  [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: height*0.036,
                ),
                label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined, size: height*0.036),
                label: 'Settings'),
          ],
          currentIndex: currentTabIndex,
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
