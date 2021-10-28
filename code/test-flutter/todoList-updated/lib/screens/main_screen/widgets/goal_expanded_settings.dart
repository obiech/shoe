// @dart=2.9
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/database/squlite.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/table_calender_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

// import 'database/squlite.dart';
import 'date_listview.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class GoalExpandedSettings extends StatefulWidget {
  final titleController;

  const GoalExpandedSettings({this.titleController, GoalModel goal});

  @override
  _GoalExpandedSettingsState createState() => _GoalExpandedSettingsState();
}

class _GoalExpandedSettingsState extends State<GoalExpandedSettings> {
  TextEditingController subtask1 = TextEditingController();
  TextEditingController subtask2 = TextEditingController();
  TextEditingController remindPeriod = TextEditingController();

  List<SubTask> subtasks = [];

  bool isNotEmpty1 = false;
  bool isNotEmpty2 = false;
  bool isSwitched = false;
  DbHelper db = DbHelper();

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

  List<CategoryModel> categories = global.store.get('categoryList');

  String dateChoose;
  String periodChoose;
  CategoryModel category;

  // var titleController;

  var _text = '';

  @override
  void initState() {
    global.store.set('Goal category', 'All');

    dateChoose = dates[0];
    periodChoose = periods[0];
    category = categories[0];
    super.initState();
  }

  function(value) => setState(() {
        // global.store.set('selectedDay', value);
        _text = value;
      });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 13, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Согласно технологии SMART цель должна быть конкретной, измеримой,'
            ' достижимой, значимой и ограниченной временем.'
            ' Придерживаясь этих критериев вы поставите перед собой реальную цель,'
            ' которую сможете выполнить.',
            style: TextStyles.dateStyle.copyWith(color: ColorPalette.grey3),
          ),
          const SizedBox(height: 20),
          Text(
            'Название цели',
            style: TextStyles.dateStyle.copyWith(
              color: ColorPalette.grey3,
            ),
          ),
          TextFormField(
            controller: widget.titleController,
            onChanged: ((val) {
              if (val != '') global.store.set('Goal Title', val);
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorPalette.grey6),
                ),
                isDense: true,
                hintText: 'Цели',
                hintStyle: TextStyles.subtitle5.copyWith(
                    color: ColorPalette.grey4, fontWeight: FontWeight.w600)),
            style: TextStyles.subtitle5.copyWith(
              color: ColorPalette.black1,
              fontWeight: FontWeight.w600,
            ),
            minLines: 1,
            maxLines: 1,
          ),
          const SizedBox(height: 20.0),
          Text(
            'Дата завершения цели',
            style: TextStyles.dateStyle.copyWith(color: ColorPalette.grey3),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () async {
              var value = await showTopModalSheet<String>(
                  context: context,
                  child: Wrap(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            color: Colors.white,
                          ),
                          child: TableCalenderWidget(
                            func: function,
                          ))
                    ],
                  ));
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: ColorPalette.grey6,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _text.toString(),
                    style: TextStyles.subtitle5.copyWith(
                      color: ColorPalette.black1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SvgPicture.asset(MainIcons.calendar),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Категория',
            style: TextStyles.dateStyle.copyWith(color: ColorPalette.grey3),
          ),
          DropdownButton(
            icon: SvgPicture.asset(MainIcons.dropdown),
            iconEnabledColor: ColorPalette.purple1,
            isExpanded: true,
            value: category,
            underline: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: ColorPalette.grey6,
                  ),
                ),
              ),
            ),
            onChanged: (value) {
              global.store.set('Goal category', (value as CategoryModel).title);
              setState(() {
                category = value;
              });
            },
            items: categories.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e.title),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Напомнить мне',
                style: TextStyles.dateStyle.copyWith(
                  color: ColorPalette.grey3,
                ),
              ),
              const SizedBox(width: 30),
              Switch(
                value: isSwitched,
                onChanged: (bool) {
                  setState(() {
                    isSwitched = bool;
                  });
                  global.store.set('Goal isReminded', isSwitched);
                },
                inactiveThumbColor: ColorPalette.grey5,
                inactiveTrackColor: ColorPalette.grey6,
                activeColor: ColorPalette.purple1,
                activeTrackColor: ColorPalette.purple3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
