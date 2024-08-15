import 'package:flutter/material.dart';
import 'package:todo_task/data/firebase_functions.dart';

import '../models/task_model.dart';

class TasksProviders with ChangeNotifier {
  List<TaskModel> tasks = [];
  List<TaskModel> updateTasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks() async {
    List<TaskModel> allTasks =
        await FirebaseFunctions.getAllTasksFromFireStore();
    tasks = allTasks
        .where((task) =>
            task.date.day == selectedDate.day &&
            task.date.month == selectedDate.month &&
            task.date.year == selectedDate.year)
        .toList();
    notifyListeners();
  }


  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> updateTasks1(TaskModel task) async {
    try {
      await FirebaseFunctions.updateTask(task);
      notifyListeners();
    } catch (e) {
      print('Error in updateTasks1: $e');
    }
  }


}
