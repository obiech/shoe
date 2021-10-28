import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/date_listview.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/long_term_goal_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class DateWidget extends StatefulWidget {
  // latefinal TaskModel task; 


  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  bool _showContent = true;

  List<String> listOfMonths = [
    "January",
    "Febuary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  late DateFormat dateFormat;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset(_showContent
                        ? MainIcons.close
                        : MainIcons.open),
                    const SizedBox(width: 10.0),
                    Text(
                      DateTime.now().day.toString()+ ' ${listOfMonths[DateTime.now().month - 1]},  ' +DateTime.now().year.toString(),
                      style: TextStyles.dateStyle.copyWith(color: ColorPalette.purple1),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _showContent = !_showContent;
                  });
                },
              )

            ],
          ),
          _showContent
              ? DateListView()
              : Offstage(),
        ],
      ),
    );
  }
}