import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/providers/tasks_providers.dart';
import 'package:todo_task/style/app_theme.dart';
import 'package:todo_task/tabs/tasks/tasks_items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTab extends StatefulWidget {
  static const String routeName = 'tasksTab';

  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {

  @override
  void initState() {
Provider.of<TasksProviders>(context,listen: false).getTasks();
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TasksProviders tasksProviders = Provider.of<TasksProviders>(context);
    double screenHeight = MediaQuery.sizeOf(context).height;
    return
      Scaffold(

    body:
      Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight * 0.16,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
            PositionedDirectional(
              start: 20,
              top: 40,
              child: Text(
                AppLocalizations.of(context)!.todoList,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  color: AppTheme.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: screenHeight * 0.1,
              ),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                focusDate: tasksProviders.selectedDate,
                lastDate: DateTime.now().add(
                  Duration(days: 365),
                ),
                showTimelineHeader: false,
                onDateChange: (selectedDate) {
                  tasksProviders.changeSelectedDate(selectedDate);
                  tasksProviders.getTasks();
                },
                activeColor: Theme.of(context).datePickerTheme.backgroundColor,
                dayProps: EasyDayProps(
                  height: 90,
                  width: 60,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Theme.of(context).datePickerTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayStrStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    monthStrStyle: TextStyle(color: Colors.transparent),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Theme.of(context).datePickerTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayStrStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    dayNumStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    monthStrStyle: TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsetsDirectional.only(top: 20),
            itemCount: tasksProviders.tasks.length,
            itemBuilder: (context, index) => TasksItems(tasksProviders.tasks[index]),
          ),
        ),
      ],),
    );
  }
}
