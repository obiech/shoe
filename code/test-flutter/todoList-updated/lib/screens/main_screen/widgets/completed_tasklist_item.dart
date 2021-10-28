import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';

class CompletedTaskListItem extends StatelessWidget {
  final TaskModel task;

  CompletedTaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.white.withOpacity(0.03),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              task.isCompleted = task.isCompleted!;
              (task.isCompleted!)
                        ? task.isCompleted = false
                        : task.isCompleted = true;
                    BlocProvider.of<TaskListBloc>(context)
                      ..add(ChangeTaskDone(task: task));
            },
            child: Container(
              width: 16,
              height: 16,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.colorPickerList[task.indicatorColor!],
              ),
              child: SvgPicture.asset(MainIcons.check),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            task.title!,
            style: TextStyles.subtitle1.copyWith(
              color: ColorPalette.grey1,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
