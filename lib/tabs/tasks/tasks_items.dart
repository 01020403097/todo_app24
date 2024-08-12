import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/app_theme.dart';

class TasksItems extends StatelessWidget {
  const TasksItems({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return  Container(
      padding: EdgeInsetsDirectional.all(20),
      margin: EdgeInsetsDirectional.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(15),
          color: AppTheme.white),
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
                'play BasketBall',
                style: textTheme.titleMedium?.copyWith(color: AppTheme.primary),
              ),
              Text(
                'this is task description',
                style: textTheme.titleSmall,
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 34,
            width: 69,
            decoration: BoxDecoration(color: AppTheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.check,color: AppTheme.white,size: 32,),),
        ],
      ),
    );
  }
}
