
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/data/firebase_functions.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/providers/tasks_providers.dart';
import 'package:todo_task/style/app_theme.dart';
import '../../components/widgets/default_elevated_button.dart';
import '../../components/widgets/default_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  GlobalKey <FormState>_key =GlobalKey<FormState>();
  TextEditingController titleTask = TextEditingController();
  TextEditingController descriptionTask = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    TextStyle? titleMediumStyle=Theme.of(context).textTheme.titleMedium;
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.55,
      padding: EdgeInsetsDirectional.all(20),
      child: Form(
        key: _key,
        child: Column(
          children: [
            Text(
                AppLocalizations.of(context)!.addNewTask,
              style: titleMediumStyle
            ),
            SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
              validator: (value) {
            if(value==null || value.trim().isEmpty){
              return AppLocalizations.of(context)!.titleCanNotBeEmpty;
            }else{
              return null;
            }
              },
              maxLines: 1,
              controller: titleTask,
              hintText: AppLocalizations.of(context)!.enterTaskTitle,
            ),
            SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
              validator: (value) {
                if(value==null || value.trim().isEmpty){
                  return AppLocalizations.of(context)!.descriptionCanNotBeEmpty;
                }else{
                  return null;
                }

              },
              maxLines: 3,
              controller: descriptionTask,
              hintText: AppLocalizations.of(context)!.enterTaskDescription,
            ),
            SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.selectDate
                ,style: titleMediumStyle?.copyWith(
              fontWeight: FontWeight.w400)),
            SizedBox(height: 16),
            InkWell(
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 365),
                      ),
                      initialDate: selectedDate,
                      initialEntryMode: DatePickerEntryMode.calendarOnly);
                  if (dateTime != null) {
                    selectedDate = dateTime;
                    setState(() {});
                  }
                },
                child: Text(
                  dateFormat.format(selectedDate),
                  style:titleMediumStyle?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                )),
            SizedBox(height: 30,),
        
            DefaultElevatedButton(
              label: AppLocalizations.of(context)!.submit,
              onPressed: () {
                if(_key.currentState!.validate()){

                  addTask();
                }

        
              },
            ),
          ],
        ),
      ),
    );
  }
  void addTask() async {

      try {
        await FirebaseFunctions.addTaskToFireStore(TaskModel(
          title: titleTask.text,
          description: descriptionTask.text,
          date: selectedDate,
        ));
        Navigator.of(context).pop();
        Provider.of<TasksProviders>(context, listen: false).getTasks();
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.theTaskIsAdding,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: AppTheme.green,
            textColor: AppTheme.white,
            fontSize: 16.0
        );
      } catch (error) {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.errorAddingTask,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: AppTheme.white,
            fontSize: 16.0
        );

      }
    }


}
