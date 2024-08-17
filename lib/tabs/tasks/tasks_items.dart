import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/providers/tasks_providers.dart';
import '../../data/firebase_functions.dart';
import '../../models/task_model.dart';
import '../../style/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'edit_tasks.dart';

class TasksItems extends StatefulWidget {
  final TaskModel task;

  TasksItems(this.task);

  @override
  _TasksItemsState createState() => _TasksItemsState();
}

class _TasksItemsState extends State<TasksItems> {
  bool isCompleted = false;

  Future<void> _loadTaskStatus() async {
    isCompleted = await TaskPreferences.getTaskStatus(widget.task.id);
  }

  @override
  void initState() {
    super.initState();
    _loadTaskStatus();
  }

  Future<void> _toggleCompletion() async {
    setState(() {
      isCompleted = !isCompleted;
    });

    try {
      await TaskPreferences.saveTaskStatus(widget.task.id, isCompleted);
    } catch (e) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.somethingWentWrong,
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double wides=MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: screenHeight*0.015,
          horizontal: wides*0.05),
      child: Slidable(
        key: ValueKey(widget.task.id),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                try {
                  // Delete from Firestore
                  FirebaseFunctions.deleteTskFromFireStore(widget.task.id);
                  // Update the tasks provider
                  Provider.of<TasksProviders>(context, listen: false).getTasks();
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.somethingWentWrong,
                  );
                  print(e);
                }
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                try {
                  showDialog(
                    context: context,
                    builder: (context) => EditTasks(widget.task),
                  );
                  Provider.of<TasksProviders>(context, listen: false).updateTasks1(widget.task);
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.somethingWentWrong,
                  );
                  print(e);
                }
              },
              backgroundColor: AppTheme.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsetsDirectional.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(15),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              Container(
                color: isCompleted ? Colors.green : AppTheme.primary,
                height: screenHeight*0.07,
                width: wides*0.01,
                margin: EdgeInsetsDirectional.only(end: wides*0.022),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: textTheme.titleMedium?.copyWith(
                      color: isCompleted ? Colors.green : AppTheme.primary,

                    ),
                  ),
                  Text(
                    widget.task.description,
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: _toggleCompletion,
                child: Container(
                  height: screenHeight*0.043,
                  width: wides*0.17,
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.green : AppTheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isCompleted
                        ? Text(
                      'Done',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: screenHeight*0.019,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : Icon(
                      Icons.check,
                      color: AppTheme.white,
                      size: screenHeight*0.036,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
