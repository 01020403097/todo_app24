import 'package:flutter/material.dart';
import 'package:todo_task/style/app_theme.dart';

class DefaultTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String hintText;
  int maxLines;
  String? Function(String?)? validator;

  DefaultTextFormField({required this.controller,required this.validator,required this.hintText,required this.maxLines});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,

      decoration: InputDecoration(hintText: hintText,
      hintStyle: Theme.of(context).textTheme.titleSmall,
      ),
      maxLines: maxLines,
      style: TextStyle(color: AppTheme.primary),



    );
  }
}
