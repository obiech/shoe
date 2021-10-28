import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/components/apply_button.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/goal_list_bloc/goal_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/expanded_settings.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:to_do_list_pro_project/utils/helper.dart';

import 'goal_expanded_settings.dart';

class GoalTaskBottomSheet extends StatefulWidget {
  @override
  _GoalTaskBottomSheetState createState() => _GoalTaskBottomSheetState();
}

class _GoalTaskBottomSheetState extends State<GoalTaskBottomSheet> {
  TextEditingController goalController = TextEditingController();

  bool showExpandedSettings = false;

  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  Helper helper = Helper();

  void clearStore() {
    // global.store.set('subtask1', null);
    global.store.set('selectedDay', null);
    global.store.set('calendar', null);
    global.store.set('category', null);
    global.store.set('periodChoose', null);
    global.store.set('isReminded', null);
  }

  List<SubTask> subtasks = [];

  bool isNotEmpty1 = false;
  bool isNotEmpty2 = false;
  bool isSwitched = false;

  List dates = [
    'Среда, 12 мая 2021',
    'Четверг, 13 мая 2021',
    'Пятница, 14 мая 2021',
  ];

  List periods = [
    'Дней',
    'Недель',
    'Месяцев',
  ];

  List<CategoryModel> categories = [
  ];

  late String dateChoose;
  late String periodChoose;
  late CategoryModel category;

  @override
  void initState() {
    categories = global.store.get('categoryList');
    
    dateChoose = dates[0];
    periodChoose = periods[0];
    category = categories[0];
    super.initState();
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              GoalExpandedSettings(titleController: titleController),
              const SizedBox(height: 10),
              ApplyButton(
                  title: Strings.apply,
                  onPressed: () {
                    if (_formKey.currentState!.validate() && global.store.get('dateTimeCalender') != null) {
                      
                      BlocProvider.of<GoalListBloc>(context)
                        ..add(AddGoalEvent(
                            goal: GoalModel(
                          title: global.store.get('Goal Title'),
                          calendar: global.store.get('dateTimeCalender').toString(),
                          category: global.store.get('Goal category') ?? 'All',
                          isRemind:
                              ((global.store.get('Goal isReminded') == false)? 0: 1),
                          isCompleted: 1,
                                    term: helper.daysBetween(global.store.get('dateTimeCalender').toString()),
                        )));
                      Navigator.pop(context);
                      clearStore();
                    }
                  }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
