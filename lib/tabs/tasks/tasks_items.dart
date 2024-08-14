import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/data/firebase_functions.dart';
import 'package:todo_task/providers/tasks_providers.dart';

import '../../models/task_model.dart';
import '../../style/app_theme.dart';

class TasksItems extends StatelessWidget {
  TasksItems(this.task);

  TaskModel task;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: 15, horizontal: 20),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                try {
                  FirebaseFunctions.deleteTskFromFireStore(task.id);
                  Provider.of<TasksProviders>(context, listen: false)
                      .getTasks();
                } catch (e) {
                  Fluttertoast.showToast(msg: 'something went wrong!');
                  print(e);
                }
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsetsDirectional.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15),
              color: Theme.of(context).cardColor),
          child: Row(
            children: [
              Container(
                color: AppTheme.primary,
                height: 62,
                width: 4,
                margin: EdgeInsetsDirectional.only(end: 15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppTheme.primary),
                  ),
                  Text(
                    task.description,
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 34,
                width: 69,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.check,
                  color: AppTheme.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
