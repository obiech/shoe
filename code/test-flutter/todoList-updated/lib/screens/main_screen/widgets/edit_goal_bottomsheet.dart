import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/components/apply_button.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/goal_list_bloc/goal_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/goal_expanded_settings.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;
import 'package:to_do_list_pro_project/utils/helper.dart';

class EditGoalBottomsheet extends StatefulWidget {
  final GoalModel goal;

  EditGoalBottomsheet({required this.goal});

  @override
  _EditGoalBottomsheetState createState() => _EditGoalBottomsheetState();
}

class _EditGoalBottomsheetState extends State<EditGoalBottomsheet> {
//   // TextEditingController subtask1 = TextEditingController();
//   // TextEditingController subtask2 = TextEditingController();
//   TextEditingController remindPeriod = TextEditingController();

//   // List<SubTask> subtasks = [];

//   bool isNotEmpty1 = false;
//   bool isNotEmpty2 = false;
//   bool isSwitched = false;
//   Helper helper = Helper();

//   List dates = [
//     'Среда, 12 мая 2021',
//     'Четверг, 13 мая 2021',
//     'Пятница, 14 мая 2021',
//   ];

//   List periods = [
//     'Дней',
//     'Недель',
//     'Месяцев',
//   ];

//   List<String> categories = [];

//   late String dateChoose;
//   late String periodChoose;
//   late String category;

//   @override
//   void initState() {
//     loadCat();

//     dateChoose = dates[0];
//     periodChoose = periods[0];
//     category = widget.goal.category!;
//     // if () {
//     //   // subtask1.text = widget.task.subtasks.first.title;
//     //   // subtask2.text = widget.task.subtasks.last.title;
//     // }
//     remindPeriod.text = widget.goal.toString();
//     isSwitched = helper.convertIntToBool(widget.goal.isRemind!);
//     super.initState();
//   }

//   Future loadCat() async {
//     await helper.getCat();
//     List<CategoryModel> a = global.store.get('categoryList');
//     for (CategoryModel b in a) {
//       categories.add(b.category!);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 13, left: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Подзадачи',
//             style: TextStyles.dateStyle.copyWith(color: ColorPalette.grey3),
//           ),
//           // Row(
//           //   mainAxisSize: MainAxisSize.min,
//           //   children: [
//           //     Expanded(
//           //       child: TextField(
//           //         onTap: () {
//           //           setState(() {});
//           //         },
//           //         onChanged: (value) {
//           //           if (value != '') {
//           //             setState(() {
//           //               isNotEmpty1 = true;
//           //             });
//           //             global.store.set('subtask1', value);
//           //           } else {
//           //             setState(() {
//           //               isNotEmpty1 = false;
//           //             });
//           //           }
//           //         },
//           //         controller: subtask1,
//           //         decoration: InputDecoration(
//           //             enabledBorder: UnderlineInputBorder(
//           //               borderSide: BorderSide(color: ColorPalette.grey6),
//           //             ),
//           //             isDense: true,
//           //             hintText: 'Подзадача 1',
//           //             hintStyle: TextStyles.subtitle5.copyWith(
//           //                 color: ColorPalette.grey4,
//           //                 fontWeight: FontWeight.w600)),
//           //         style: TextStyles.subtitle5.copyWith(
//           //           color: ColorPalette.black1,
//           //           fontWeight: FontWeight.w600,
//           //         ),
//           //         minLines: 1,
//           //         maxLines: 1,
//           //       ),
//           //     ),
//           //     const SizedBox(width: 20),
//           //     isNotEmpty1
//           //         ? GestureDetector(
//           //         onTap: () {
//           //           subtask1.clear();
//           //           setState(() {
//           //             isNotEmpty1 = false;
//           //           });
//           //         },
//           //         child: SvgPicture.asset(MainIcons.cleanText))
//           //         : const SizedBox(
//           //       width: 17,
//           //     ),
//           //   ],
//           // ),
//           // const SizedBox(height: 20),
//           // Row(
//           //   mainAxisSize: MainAxisSize.min,
//           //   children: [
//           //     Expanded(
//           //       child: TextField(
//           //         onChanged: (value) {
//           //           if (value != '') {
//           //             setState(() {
//           //               isNotEmpty2 = true;
//           //             });
//           //             global.store.set('subtask2', subtask2.text);
//           //           } else {
//           //             setState(() {
//           //               isNotEmpty2 = false;
//           //             });
//           //           }
//           //         },
//           //         controller: subtask2,
//           //         decoration: InputDecoration(
//           //             enabledBorder: UnderlineInputBorder(
//           //               borderSide: BorderSide(color: ColorPalette.grey6),
//           //             ),
//           //             isDense: true,
//           //             hintText: 'Подзадача 2',
//           //             hintStyle: TextStyles.subtitle5.copyWith(
//           //                 color: ColorPalette.grey4,
//           //                 fontWeight: FontWeight.w600)),
//           //         style: TextStyles.subtitle5.copyWith(
//           //           color: ColorPalette.black1,
//           //           fontWeight: FontWeight.w600,
//           //         ),
//           //         minLines: 1,
//           //         maxLines: 1,
//           //       ),
//           //     ),
//           //     const SizedBox(width: 20),
//           //     isNotEmpty2
//           //         ? GestureDetector(
//           //         onTap: () {
//           //           subtask2.clear();
//           //           setState(() {
//           //             isNotEmpty2 = false;
//           //           });
//           //         },
//           //         child: SvgPicture.asset(MainIcons.cleanText))
//           //         : const SizedBox(
//           //       width: 17,
//           //     ),
//           //   ],
//           // ),
//           const SizedBox(height: 20),
//           Text(
//             'Дата',
//             style: TextStyles.dateStyle.copyWith(color: ColorPalette.grey3),
//           ),
//           const SizedBox(height: 4),
//           Container(
//             padding: EdgeInsets.only(bottom: 4),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   width: 1.0,
//                   color: ColorPalette.grey6,
//                 ),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Среда, 12 мая 2021',
//                   style: TextStyles.subtitle5.copyWith(
//                     color: ColorPalette.black1,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: SvgPicture.asset(MainIcons.calendar),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Повтор каждые',
//             style: TextStyles.dateStyle.copyWith(color: ColorPalette.grey3),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.only(top: 4),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         width: 1.0,
//                         color: ColorPalette.grey6,
//                       ),
//                     ),
//                   ),
//                   child: TextField(
//                     controller: remindPeriod,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       isCollapsed: true,
//                       isDense: true,
//                     ),
//                     onChanged: (value) {
//                       global.store.set(remindPeriod, value);
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 40),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         width: 1.0,
//                         color: ColorPalette.grey6,
//                       ),
//                     ),
//                   ),
//                   child: DropdownButton(
//                     underline: Offstage(),
//                     icon: SvgPicture.asset(MainIcons.dropdown),
//                     iconEnabledColor: ColorPalette.purple1,
//                     isExpanded: true,
//                     isDense: true,
//                     value: periodChoose,
//                     onChanged: (value) {
//                       global.store.set('periodChoose', periodChoose);
//                       setState(() {
//                         periodChoose = value.toString();
//                       });
//                     },
//                     items: periods.map((e) {
//                       return DropdownMenuItem(
//                         value: e,
//                         child: Text(e),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Категория',
//             style: TextStyles.dateStyle.copyWith(color: ColorPalette.grey3),
//           ),
//           DropdownButton(
//             icon: SvgPicture.asset(MainIcons.dropdown),
//             iconEnabledColor: ColorPalette.purple1,
//             isExpanded: true,
//             value: category,
//             underline: Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     width: 1.0,
//                     color: ColorPalette.grey6,
//                   ),
//                 ),
//               ),
//             ),
//             onChanged: (value) {
//               global.store.set('category', value);
//               setState(() {
//                 category = value.toString();
//               });
//             },
//             items: categories.map((e) {
//               return DropdownMenuItem(
//                 value: e,
//                 child: Text(e),
//               );
//             }).toList(),
//           ),
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 'Напомнить мне',
//                 style: TextStyles.dateStyle.copyWith(
//                   color: ColorPalette.grey3,
//                 ),
//               ),
//               const SizedBox(width: 30),
//               Switch(
//                 value: isSwitched,
//                 onChanged: (bool) {
//                   setState(() {
//                     isSwitched = bool;
//                   });
//                   global.store.set('isReminded', isSwitched);
//                 },
//                 inactiveThumbColor: ColorPalette.grey5,
//                 inactiveTrackColor: ColorPalette.grey6,
//                 activeColor: ColorPalette.purple1,
//                 activeTrackColor: ColorPalette.purple3,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

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

  List<CategoryModel> categories = [];

  late String dateChoose;
  late String periodChoose;
  late CategoryModel category;

  @override
  void initState() {
    categories = global.store.get('categoryList');
    titleController.text = widget.goal.title!;
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
              GoalExpandedSettings(
                  titleController: titleController, goal: widget.goal),
              const SizedBox(height: 10),
              ApplyButton(
                  title: Strings.apply,
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        global.store.get('selectedDay') != null) {
                      widget.goal.title = titleController.text;
                      widget.goal.calendar =
                          global.store.get('selectedDay').toString();
                      widget.goal.category =
                          global.store.get('Goal category') ?? 'All';
                      widget.goal.isRemind =
                          ((global.store.get('Goal isReminded') == false)
                              ? 0
                              : 1);
                      widget.goal.isCompleted = 1;
                      widget.goal.term = helper.daysBetween(
                          global.store.get('selectedDay').toString());
                      BlocProvider.of<GoalListBloc>(context)
                        ..add(EditGoalEvent(
                            goal: widget.goal));
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
