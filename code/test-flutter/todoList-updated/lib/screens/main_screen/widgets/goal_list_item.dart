import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/goal_list_bloc/goal_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:to_do_list_pro_project/utils/helper.dart';

class GoalListItem extends StatefulWidget {
  final GoalModel goal;
  final Color color;

  GoalListItem({required this.goal, required this.color});

  @override
  _GoalListItemState createState() => _GoalListItemState();
}

class _GoalListItemState extends State<GoalListItem> {
  bool _showContent = false;
  Helper helper = Helper();
  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat('EEE. dd MMM', 'ru');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // InkWell(
                //   onTap: () {
                //     BlocProvider.of<GoalListBloc>(context)
                //       ..add(ChangeGoalDone(goal: widget.goal));
                //   },
                //   child: Container(
                //     width: 15,
                //     height: 15,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       border: Border.all(width: 1, color: Colors.red),
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.goal.title!,
                        style: TextStyles.goalText
                            .copyWith(color: ColorPalette.black1),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.goal.category!,
                            style: TextStyles.subtitle4
                                .copyWith(color: ColorPalette.grey1, height: 1),
                          ),
                          Text(
                            helper
                                    .daysBetween(widget.goal.calendar!)
                                    .toString() +
                                '  дней осталось',
                            style: TextStyles.subtitle4.copyWith(
                              color: widget.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _showContent
              ? Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: ColorPalette.grey2,
                      ),
                    ),
                  ),
                  // child: ,
                )
              : Offstage(),
        ],
      ),
    );
  }
}
