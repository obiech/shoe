import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_list_item.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';

class SlidableWidget extends StatelessWidget {
  final TaskModel task;

  SlidableWidget({required Key key, required this.task,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        child: TaskListItem(
          task: task,
        ),
        actionExtentRatio: 0.12,
        secondaryActions: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<TaskListBloc>(context)
                ..add(RemoveTaskEvent(task: task));
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -20,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: ColorPalette.purple2,
                    ),
                    width: 60,
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: SvgPicture.asset(MainIcons.basket),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
