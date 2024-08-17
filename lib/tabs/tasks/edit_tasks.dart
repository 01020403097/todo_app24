import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/providers/tasks_providers.dart';
import 'package:todo_task/style/app_theme.dart';
import 'package:todo_task/tabs/tasks/tasks_tab.dart';
import '../../components/widgets/default_elevated_button.dart';
import '../../components/widgets/default_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTasks extends StatefulWidget {


  EditTasks(this.task);

  TaskModel task;


  @override
  State<EditTasks> createState() => _EditTasksState();
}



class _EditTasksState extends State<EditTasks> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController titleEditTask;
  late TextEditingController descriptionEditTask;
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    titleEditTask = TextEditingController(text: widget.task.title);
    descriptionEditTask =
        TextEditingController(text: widget.task.description);
    selectedDate = widget.task.date;
  }

  @override
  void dispose() {
    titleEditTask.dispose();
    descriptionEditTask.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? titleMediumStyle = Theme.of(context).textTheme.titleMedium;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double wides=MediaQuery.sizeOf(context).width;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.todoList,
          style: titleMediumStyle!.copyWith(color: AppTheme.white),
        ),
        flexibleSpace: Container(),
        toolbarHeight: screenHeight*0.18,
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: wides*0.05),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: screenHeight*0.015),
                        child: Text(
                          AppLocalizations.of(context)!.editTask,
                          style: titleMediumStyle,
                        ),
                      ),
                       SizedBox(height: screenHeight*0.017),
                      DefaultTextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .titleCanNotBeEmpty;
                          }
                          return null;
                        },
                        maxLines: 1,
                        controller: titleEditTask,
                        hintText: AppLocalizations.of(context)!.thisIsTitle,
                      ),
                       SizedBox(height: screenHeight*0.018),
                      DefaultTextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .descriptionCanNotBeEmpty;
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: descriptionEditTask,
                        hintText: AppLocalizations.of(context)!.taskDetails,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.selectDate,
                        style: titleMediumStyle?.copyWith(
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            initialDate: selectedDate,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          );
                          if (dateTime != null) {
                            setState(() {
                              selectedDate = dateTime;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dateFormat.format(selectedDate),
                            style: titleMediumStyle!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                       SizedBox(height: screenHeight*0.032),
                      DefaultElevatedButton(
                        label: AppLocalizations.of(context)!.saveChanges,
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            widget.task.title = titleEditTask.text;
                            widget.task.description = descriptionEditTask.text;
                            widget.task.date = selectedDate;
                            await Provider.of<TasksProviders>(context, listen: false).updateTasks1(widget.task);
                            Navigator.of(context).pushNamed(TasksTab.routeName);
                            print('Task ID: ${widget.task.id}');
                            print('Task Title: ${widget.task.title}');
                            print('Task Description: ${widget.task.description}');
                            print('Task Date: ${widget.task.date}');

                          }
                        },


                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
