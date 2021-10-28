import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen2.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen1.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_expanded_settings.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/edit_task_bottomsheet.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:to_do_list_pro_project/utils/helper.dart';

import '../../../data/models/task_model.dart';
import '../../../database/squlite.dart';

// import 'database/squlite.dart';

class MyBottomNavbar extends StatefulWidget {
  @override
  _MyBottomNavbarState createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {
  int _currentIndex = 0;
  Helper helper = Helper();
  DbHelper db = DbHelper();

  final List<Widget> _children = [
    Screen2(),
    Screen1(),
    Screen(),
  ];
  List<TaskModel>? task = [];

  void check() async {
    task = await db.getDocsTask();
    if (task!.isNotEmpty) {
      task = task?.where((element) => element.isCompleted == false).toList();
      for (int i = 0; i < task!.length; i++) {
        if (!task![i].isRemind!) continue;
        if (DateTime.now().difference(task![i].remindDate!).isNegative) {
          int diff = helper.daysBetween(task![i].repeatDays!.toString());
        reminderAlert(context, task![i], diff.toString());
          break;
        }
      }
    }
  }

  Future<String?> reminderAlert(
      BuildContext context, TaskModel task, String diff) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Reminder',
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 160,
          child: Column(
            children: [
              Text(
                'Task ${task.title} Starts In $diff Hour',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  task.isRemind = false;
                  BlocProvider.of<TaskListBloc>(context)
                    ..add(EditTaskEvent(task: task));
                  Navigator.pop(context);
                },
                child: Container(
                  child: Center(
                      child: Text(
                    'Accept',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                  decoration: BoxDecoration(
                      color: Color(0xFF7D63EB),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: 255.0,
                  height: 40.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: (() {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Wrap(
                          children: [
                            BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: EditTaskBottomSheet(
                                  task: task,
                                )),
                          ],
                        );
                      });
                }),
                child: Container(
                  child: Center(
                      child: Text(
                    'Move',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: 255.0,
                  height: 40.0,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    // reminderAlert(context,);
    check();
  }

  @override
  void initState() {
    super.initState();
    helper.getCat();
    // helper.showAlert(a, isFirst)
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorPalette.white1,
        selectedItemColor: ColorPalette.purple1,
        unselectedItemColor: ColorPalette.grey3,
        elevation: 0.0,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.track_changes_outlined),
            label: "Цели",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.donut_large_outlined),
            label: "Колесо",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.fact_check_outlined),
            label: "Задачи",
          ),
        ],
      ),
    );
  }
}
