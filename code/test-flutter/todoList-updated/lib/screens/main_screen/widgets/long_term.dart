import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/icons.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/long_term_goal_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class LongTerm extends StatefulWidget {
  late final GoalModel goal;


  @override
  _LongTermState createState() => _LongTermState();
}

class _LongTermState extends State<LongTerm> {
  bool _showContent = false;

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
                      'Долгосроные',
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
              ? LongTermGoalWidget()
              : Offstage(),
        ],
      ),
    );
  }
}