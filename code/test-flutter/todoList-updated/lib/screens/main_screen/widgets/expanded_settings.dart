import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/components/apply_task_button.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/time_cubit/timechange_cubit.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/table_calender_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:to_do_list_pro_project/utils/helper.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class ExpandedSettings extends StatefulWidget {
  @override
  _ExpandedSettingsState createState() => _ExpandedSettingsState();
}

class _ExpandedSettingsState extends State<ExpandedSettings> {
  TextEditingController taskController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  List<GlobalKey<FormState>> _subTaskKey = [];

  int numberOfSubtasks = 0;

  TimeOfDay? newTime;

  var _text2 = '';

  TimeOfDay? reminderTime;

  // late String value4;

  List<SubTask> addSubtasks() {
    List<SubTask> subtasks = [];
    for (int i = 0; i < numberOfSubtasks; i++)
      // if (global.store.get('subtask1') != null) {
      subtasks.add(SubTask(title: _subTaskController[i].text));
    // _subTaskKey.add(GlobalKey());
    //   }
    // if (global.store.get('subtask2') != null) {
    //   subtasks.add(SubTask(title: global.store.get('subtask2')));
    // }
    return subtasks;
  }

  Helper helper = Helper();

  List<TextEditingController> _subTaskController = [];

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

  List<CategoryModel> categories = [];

  List<String> timeFrames = [
    'Days',
    'Weeks',
    'Months',
  ];

  late String dateChoose;
  late String periodChoose;
  CategoryModel? category;
  late String timeFrame;
  int newSubTask = 0;

  void clearStore() {
    global.store.set('subtask1', null);
    global.store.set('subtask2', null);
    global.store.set('category', null);
    global.store.set('periodChoose', null);
    global.store.set('isReminded', null);
    global.store.set('timeFrame', null);
  }

  var _text = '';

  @override
  void initState() {
    categories = global.store.get('categoryList');
    dateChoose = dates[0];
    periodChoose = periods[0];
    category = categories[0];
    timeFrame = timeFrames[0];
    global.store.set('category', category);
    global.store.set('categoryColor', category);

    super.initState();
  }

  function(value) => setState(() {
        global.store.set('selectedDay', value);
        _text = value;
      });
  function2(value) => setState(() {
        global.store.set('selectedtime', value);
        _text2 = value;
      });

  void subTask() {
    for (int i = 0; i <= numberOfSubtasks; i++)
      _subTaskController.add(TextEditingController());
  }

  bool viewVisible = false;

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Название задачи',
          style: TextStyles.dateStyle.copyWith(
            color: ColorPalette.grey3,
          ),
        ),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: taskController,
            validator: (value) {
              if (value == '') {
                return 'Введите название';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorPalette.grey6),
                ),
                isDense: true,
                hintText: 'Выгулять собаку',
                hintStyle: TextStyles.subtitle5.copyWith(
                    color: ColorPalette.grey4, fontWeight: FontWeight.w600)),
            style: TextStyles.subtitle5.copyWith(
              color: ColorPalette.black1,
              fontWeight: FontWeight.w600,
            ),
            minLines: 1,
            maxLines: 1,
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: Column(
              children: List.generate(
                  numberOfSubtasks, (index) => subTaskWidget(index))),
        ),
        SizedBox(height: 15.0),
        Row(
          children: <Widget>[
            Expanded(
              child: DropdownButton(
                iconDisabledColor: ColorPalette.transparent,
                iconEnabledColor: ColorPalette.transparent,
                style: TextStyles.dateStyle,
                // icon: SvgPicture.asset(MainIcons.dropdown),
                // iconEnabledColor: ColorPalette.purple1,
                isExpanded: true,
                value: category,
                underline: DropdownButtonHideUnderline(child: Container()),
                onChanged: (value) {
                  global.store.set('category', value);
                  global.store.set('categoryColor', value);
                  setState(() {
                    category = value as CategoryModel?;
                  });
                },
                items: categories.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.title!),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 30.0),
            GestureDetector(
              child: SingleChildScrollView(
                  child: Container(height: 18,width: 18,
                      child: SvgPicture.asset(
                MainIcons.calendar,
              ))),
              onTap: () async {
                await showTopModalSheet<String>(
                    context: context,
                    child: SingleChildScrollView(
                        child: Wrap(children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            TableCalenderWidget(
                              func: function,
                            ),
                            SizedBox(height: 20.0),
                            BlocBuilder<TimechangeCubit, TimechangeState>(
                                builder: (context, state) {
                              if (state is TimeChange)
                                return Column(children: [
                                  Align(
                                    child: Text(
                                      'Repeat Every',
                                      style: TextStyles.dateStyle,
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Form(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          ColorPalette.grey6),
                                                ),
                                                isDense: true,
                                                hintText: '7',
                                                hintStyle: TextStyles.subtitle5
                                                    .copyWith(
                                                        color:
                                                            ColorPalette.grey4,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            style:
                                                TextStyles.subtitle5.copyWith(
                                              color: ColorPalette.black1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            keyboardType: TextInputType.number,
                                            minLines: 1,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60.0,
                                      ),
                                      Expanded(
                                        child: DropdownButton(
                                          style: TextStyles.dateStyle,
                                          icon: SvgPicture.asset(
                                              MainIcons.dropdown),
                                          iconEnabledColor:
                                              ColorPalette.purple1,
                                          isExpanded: true,
                                          value: timeFrame,
                                          onChanged: (value) {
                                            global.store
                                                .set('timeFrame', value);
                                            setState(() {
                                              timeFrame = value.toString();
                                            });
                                          },
                                          items: timeFrames.map((e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          child: SvgPicture.asset(
                                        MainIcons.time,
                                      )),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                              onTap: (() async {
                                                global.store
                                                    .set('TaskTime', newTime);
                                                newTime = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  initialEntryMode:
                                                      TimePickerEntryMode.input,
                                                );
                                                BlocProvider.of<
                                                            TimechangeCubit>(
                                                        context)
                                                    .onTimeChange(
                                                        newTime?.format(
                                                                context) ??
                                                            DateTime.now(),
                                                        reminderTime?.format(
                                                                context) ??
                                                            DateTime.now());
                                              }),
                                              child: Container(
                                                  child: Text('Time')))),
                                      Container(
                                          child:
                                              Text((state.newTime.toString())))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          child: SvgPicture.asset(
                                        MainIcons.reminder,
                                      )),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                            onTap: (() async {
                                              global.store
                                                  .set('reminderTime', null);
                                              reminderTime =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                initialEntryMode:
                                                    TimePickerEntryMode.input,
                                              );
                                              global.store.set(
                                                  'reminderTime', reminderTime);
                                              BlocProvider.of<TimechangeCubit>(
                                                      context)
                                                  .onTimeChange(
                                                      newTime?.format(
                                                              context) ??
                                                          DateTime.now(),
                                                      reminderTime?.format(
                                                              context) ??
                                                          DateTime.now());
                                            }),
                                            child: Container(
                                                child: Text('Reminder'))),
                                      ),
                                      Container(
                                          child: Text(
                                              (state.reminderTime.toString())))
                                    ],
                                  ),
                                  SizedBox(height: 40.0),
                                  Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: DoneButtonWidget(),
                                  ),
                                  SizedBox(height: 30.0),
                                ]);
                              else {
                                return Container();
                              }
                            })
                          ]),
                        ),
                      )
                    ])));
              },
            ),
            SizedBox(
              width: 30.0,
            ),
            GestureDetector(
                child: Container(height: 18,width: 18,
                    child: SvgPicture.asset(
                  MainIcons.miniMenu,
                )),
                onTap: (() {
                  setState(() {
                    numberOfSubtasks = numberOfSubtasks + 1;
                    _subTaskController.add(TextEditingController());
                    // _subTaskKey.add(GlobalKey());
                  });
                })),
            SizedBox(
              width: 30.0,
            ),
            ApplyTaskButton(
                title: Strings.add,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    DateTime reminderDate = DateTime(
                      (global.store.get('dateTimeCalender') as DateTime?)
                              ?.year ??
                          DateTime.now().year,
                      (global.store.get('dateTimeCalender') as DateTime?)
                              ?.month ??
                          DateTime.now().month,
                      (global.store.get('dateTimeCalender') as DateTime?)
                              ?.day ??
                          DateTime.now().day,
                      (global.store.get('reminderTime') as TimeOfDay?)?.hour.toInt()?? DateTime.now().hour,
                      (global.store.get('reminderTime') as TimeOfDay?)?.minute.toInt()?? DateTime.now().minute,


                    );
                    DateTime taskDate = DateTime(
                      (global.store.get('dateTimeCalender') as DateTime?)
                              ?.year ??
                          DateTime.now().year,
                      (global.store.get('dateTimeCalender') as DateTime?)
                              ?.month ??
                          DateTime.now().month,
                      (global.store.get('dateTimeCalender') as DateTime?)
                              ?.day ??
                          DateTime.now().day,
                      (global.store.get('TaskTime') as TimeOfDay?)?.hour.toInt()?? DateTime.now().hour,
                      (global.store.get('TaskTime') as TimeOfDay?)?.minute.toInt()?? DateTime.now().minute,

                      
                    );
                    BlocProvider.of<TaskListBloc>(context)
                      ..add(AddTaskEvent(
                          task: TaskModel(
                              title: taskController.text,
                              subtasks: addSubtasks(),
                              isRemind: global.store.get('reminderTime') != null
                                  ? true
                                  : false,
                              isRepeatable:
                                  global.store.get("repeatDays") != null
                                      ? true
                                      : false,
                              repeatDays: taskDate,
                              isCompleted: false,
                              category: (global.store.get('category')
                                      as CategoryModel)
                                  .title,
                              indicatorColor: (global.store.get('categoryColor')
                                      as CategoryModel)
                                  .color,
                              remindDate: reminderDate)));
                    Navigator.pop(context);
                    clearStore();
                  }
                }),
          ],
        ),
      ],
    );
  }

  Container subTaskWidget(int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0)
                Text(
                  'Подзадачи',
                  style: TextStyles.dateStyle.copyWith(
                    color: ColorPalette.grey3,
                  ),
                ),
              Container(
                child: Form(
                    // key: _subTaskKey[index],
                    child: TextFormField(
                  // validator: ((value) {
                  //   if (value!.isEmpty || value == '')
                  //     return 'input value or remove';
                  // }),
                  controller: _subTaskController[index],
                  decoration: InputDecoration(
                    // labelText: (index == 0) ? 'Зайти в аптеку' : null,
                    labelStyle: TextStyles.subtitle5.copyWith(
                        color: ColorPalette.grey4, fontWeight: FontWeight.w600),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.grey6),
                    ),
                    isDense: true,
                    // LabelText: 'Зайти в аптеку',
                    // hintStyle: TextStyles.subtitle5.copyWith(
                    //     color: ColorPalette.grey4,
                    //     fontWeight: FontWeight.w600
                  ),
                  style: TextStyles.subtitle5.copyWith(
                    color: ColorPalette.black1,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 1,
                )),
                width: 240.0,
                height: 30.0,
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Container(
            child: GestureDetector(
                child: SvgPicture.asset(
                  MainIcons.cancel,
                  width: 15.0,
                  height: 15.0,
                ),
                onTap: (() {
                  setState(() {
                    numberOfSubtasks = numberOfSubtasks - 1;
                  });
                })),
          ),
        ],
      ),
    );
  }
}

// class ReminderAlert extends StatelessWidget {
//   const ReminderAlert({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => reminderAlert(context),
//       child: Container(child: Text('22:55')),
//     );
//   }

Future<String?> reminderAlert(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text(
        'Reminder',
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Task "Conference in ZOOM" starts in 5 minutes',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context, 'Cancel'),
          child: Container(
            child: Center(
                child: Text(
              'Accept',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
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
          onTap: () => Navigator.pop(context, 'Close'),
          child: Container(
            child: Center(
                child: Text(
              'Move',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
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
  );
}
// }

// class Permission extends StatelessWidget {
//   const Permission({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () => permission(context),
//         child: Container(child: Text('Reminder')));
//   }

Future<String?> permission(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // title: const Text('AlertDialog Title'),
      content: const Text(
        'For the reminder to work, enable permission for autorun',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context, 'Cancel'),
          child: Container(
            child: Center(
                child: Text(
              'Enable',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
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
          onTap: () => Navigator.pop(context, 'Cancel'),
          child: Container(
            child: Center(
                child: Text(
              'Later',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            )),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: 255.0,
            height: 40.0,
          ),
        ),
      ],
    ),
  );
}
// }

class DoneButtonWidget extends StatelessWidget {
  const DoneButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.pop(context);
      }),
      child: Container(
        width: 255,
        height: 40,
        child: Center(
            child: Text(
          'Done',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
        )),
        decoration: BoxDecoration(
            color: Color(0xFF7D63EB),
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    );
  }
}
