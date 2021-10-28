import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/components/apply_button.dart';
import 'package:to_do_list_pro_project/components/apply_task_button.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/time_cubit/timechange_cubit.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_expanded_settings.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/expanded_settings.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/table_calender_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:to_do_list_pro_project/utils/helper.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final TaskModel task;

  EditTaskBottomSheet({required this.task});

  @override
  _EditTaskBottomSheetState createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
 TextEditingController taskController = TextEditingController();

  bool showExpandedSettings = false;

  GlobalKey<FormState> _formKey = GlobalKey();

  List<SubTask> addSubtasks() {
    List<SubTask> subtasks = [];
    if (global.store.get('subtask1') != null) {
      subtasks.add(SubTask(title: global.store.get('subtask1')));
    }
    if (global.store.get('subtask2') != null) {
      subtasks.add(SubTask(title: global.store.get('subtask2')));
    }
    return subtasks;
  }

  void clearStore() {
    global.store.set('subtask1', null);
    global.store.set('subtask2', null);
    global.store.set('category', null);
    global.store.set('periodChoose', null);
    global.store.set('isReminded', null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.only(
          top: 44,
          bottom: 50,
          left: 30,
          right: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            EditExpandedSettings(task: widget.task,),
          ],
        ),
      ),
    );
  }
}
