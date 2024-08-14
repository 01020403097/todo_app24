import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/providers/tasks_providers.dart';
import 'package:todo_task/style/app_theme.dart';
import 'package:todo_task/tabs/tasks/tasks_items.dart';

class TasksTab extends StatelessWidget {
  static const String routeName = 'tasksTab';

  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    TasksProviders tasksProviders = Provider.of<TasksProviders>(context);
    double screenHight=MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenHight*0.16,
              width: double.infinity,
              color:Theme.of(context).primaryColor ,),
            PositionedDirectional(
              start:20 ,
              top: 40,
              child: Text('ToDo List',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20,color: AppTheme.white),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: screenHight*0.1
              ),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                focusDate: tasksProviders.selectedDate,
                lastDate: DateTime.now().add(
                  Duration(days: 365),),
                showTimelineHeader: false,
                onDateChange: (selectedDate) {
                  tasksProviders.changeSelectedDate(selectedDate);
                  tasksProviders.getTasks();
                },
                activeColor:Theme.of(context).datePickerTheme.backgroundColor,
                dayProps: EasyDayProps(
                  height: 90,
                  width: 60,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(color: Theme.of(context).datePickerTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                    ),
                    dayStrStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                    monthStrStyle:TextStyle(color: Colors.transparent) ,

                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color:Theme.of(context).datePickerTheme.backgroundColor ,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayStrStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                    dayNumStyle:Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold) ,
                    monthStrStyle:TextStyle(color: Colors.transparent) ,

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
          itemBuilder: (context, index) =>
              TasksItems(tasksProviders.tasks[index]),
        ))
      ],
    );
  }
}
