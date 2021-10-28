import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/completed_tasklist.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_task_bottomsheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/expanded_settings.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/slidable_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_bottom_sheet.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:to_do_list_pro_project/utils/helper.dart';

class TaskListWidget extends StatelessWidget {
  var categoryName;
  Helper helper = Helper();

  List<TaskModel>? currentTasks;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      builder: (context, state) {
        if (state is TaskListInitial) {
          BlocProvider.of<TaskListBloc>(context)..add(TaskListLoadEvent());
        }
        if (state is TaskListLoading) {
          return Padding(
            padding: EdgeInsets.only(top: 200),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TaskListLoaded) {
          if (state.currentTasks.length == 0 &&
              state.completedTasks.length == 0) {
            return Padding(
              padding: EdgeInsets.only(top: 200),
              child: Center(
                child: Text(
                  'Добавьте первую задачу',
                  style:
                      TextStyles.subtitle1.copyWith(color: ColorPalette.grey1),
                ),
              ),
            );
          }
          currentTasks = [];
          if (global.store.get('categoryName') != 'All') {
            currentTasks = state.currentTasks
                .where((element) =>
                    element.category == global.store.get('categoryName'))
                .where((element) =>
                    element.remindDate!.month ==
                    (global.store.get('selectedDate') as DateTime).month)
                .where((element) =>
                    element.remindDate!.day ==
                    (global.store.get('selectedDate') as DateTime).day)
                .toList();
          } else {
            currentTasks = state.currentTasks
                .where((element) =>
                    element.remindDate!.month ==
                    (global.store.get('selectedDate') as DateTime).month)
                .where((element) =>
                    element.remindDate!.day ==
                    (global.store.get('selectedDate') as DateTime).day)
                .toList();
          }
          return Column(
            children: [
              ListView.builder(
                  itemCount: currentTasks!
                          .length,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = currentTasks ?? state.currentTasks[index];
                    return GestureDetector(
                      // onTap: (() {
                      //   if (helper.showAlert(
                      //       state.currentTasks[index].remindDate!, true))
                      //     reminderAlert(context);
                      // }),
                      // onLongPress: () {
                      //   _showMaterialDialog(
                      //     context,
                      //     state.currentTasks[index],
                      //   );
                      // },
                      child: SlidableWidget(
                        //Key for sliding items
                        key: ObjectKey(item),
                        task: currentTasks![index],
                      ),
                    );
                  }),
              const SizedBox(height: 10),
              state.completedTasks.isNotEmpty
                  ? CompletedTaskList(completedTasks: state.completedTasks)
                  : Offstage(),
            ],
          );
        } else if (state is TaskListError) {
          return Center(
            child: Text('Error'),
          );
        } else {
          return Offstage();
        }
      },
    );
  }
}
