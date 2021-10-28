import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/completed_tasklist_item.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_list_item.dart';
import 'package:to_do_list_pro_project/theme/themes.dart';

class CompletedTaskList extends StatefulWidget {
  final List<TaskModel> completedTasks;

  CompletedTaskList({required this.completedTasks});

  @override
  _CompletedTaskListState createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  bool showCompleted = true;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showCompleted = !showCompleted;
            });
          },
          child: Row(
            children: [
              SvgPicture.asset(
                showCompleted ? MainIcons.close : MainIcons.open,
              ),
              const SizedBox(width: 10),
              Text(
                Strings.completed,
                style:
                    TextStyles.dateStyle.copyWith(color: ColorPalette.purple1),
              ),
            ],
          ),
        ),
        showCompleted
            ? ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: widget.completedTasks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CompletedTaskListItem(
                        task: widget.completedTasks[index]),
                  );
                })
            : Offstage(),
      ],
    );
  }
}
