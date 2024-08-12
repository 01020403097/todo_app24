import 'package:flutter/material.dart';
import 'package:todo_task/style/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({required this.label, required this.onPressed});

  String label;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:  ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 52)
      ),
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppTheme.white, fontWeight: FontWeight.w400),
        ));
  }
}
