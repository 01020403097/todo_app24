import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/tabs/tasks/tasks_items.dart';

import '../../models/task_model.dart';

class TasksTab extends StatelessWidget {
  static const String routeName = 'tasksTab';

  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = List.generate(
      10,
      (index) => TaskModel(title: 'Task # ${index+1} title',
          description: 'description # ${index+1} description',
          date: DateTime.now()),
    );

    return SafeArea(
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
              firstDate: DateTime.now().subtract(Duration(days: 30)),
              focusDate: DateTime.now(),
              lastDate: DateTime.now().add(
                Duration(days: 30),
              ),
              showTimelineHeader: false),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsetsDirectional.only(top: 20),
            itemCount: tasks.length,
            itemBuilder: (context, index) => TasksItems(tasks[index]),
          ))
        ],
      ),
    );
  }
}
