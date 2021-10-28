import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/goal_list_bloc/goal_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_list_item.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';

import 'goal_list_item.dart';

class GoalSlidableWidget extends StatelessWidget {
  final GoalModel goal;
  final Color color;

  GoalSlidableWidget({
    required Key key,
    required this.goal,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        child: GoalListItem(
          goal: goal,
          color: color,
        ),
        actionExtentRatio: 0.12,
        secondaryActions: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<GoalListBloc>(context)
                ..add(RemoveGoalEvent(goal: goal));
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
