import 'package:flutter/material.dart';
import 'package:todo_task/tabs/tasks/task_Item.dart';

class TasksTab extends StatelessWidget {
  static const String routeName = 'tasksTab';

  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Expanded(child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => TaskItem(),))
    ],);
  }
}
