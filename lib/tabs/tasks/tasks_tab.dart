import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/tabs/tasks/tasks_items.dart';

class TasksTab extends StatelessWidget {
  static const String routeName = 'tasksTab';

  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            children: [
            EasyInfiniteDateTimeLine(firstDate: DateTime.now().subtract(Duration(days: 30)),
        focusDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30),),
            showTimelineHeader: false ),


   
    Expanded(child: ListView.builder(
      padding: EdgeInsetsDirectional.only(top: 20),
    itemCount: 5,
    itemBuilder: (context, index) => TasksItems(),))
    ],)
    ,
    );
  }
}
