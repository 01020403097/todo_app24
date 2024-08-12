
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/widgets/default_elevated_button.dart';
import '../../components/widgets/default_text_form_field.dart';

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
              'Add new task',
              style: titleMediumStyle
            ),
            SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
              validator: (value) {
            if(value==null || value.trim().isEmpty){
              return 'title can`t be embty';
            }else{
              return null;
            }
              },
              maxLines: 1,
              controller: titleTask,
              hintText: 'Enter task title',
            ),
            SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
              validator: (value) {
                if(value==null || value.trim().isEmpty){
                  return 'description can`t be embty';
                }else{
                  return null;
                }

              },
              maxLines: 3,
              controller: descriptionTask,
              hintText: 'Enter task description',
            ),
            SizedBox(height: 16),
            Text('select date',style: titleMediumStyle?.copyWith(
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
              label: 'Submit',
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
  void addTask(){}
}
