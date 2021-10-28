import 'dart:ui';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/screens/advertisement_screen/screen.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/alert_cubit/cubit/alertcubit_cubit.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/categories_list_row.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/date_listview.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/date_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/draggable_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/drawer_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/expanded_settings.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_bottom_sheet.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/task_list_widget.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';
import 'package:to_do_list_pro_project/theme/text_theme.dart';
import 'package:to_do_list_pro_project/utils/helper.dart';
// import 'package:draggable_fab/draggable_fab.dart';

// import 'package:date_widget.dart';
class Screen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlertcubitCubit>(context).emit(AlertcubitShow( 'j'));
    // .check(
    //     context, DateTime.now(), true, DateTime.parse("1969-07-20 20:18:04Z"));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: ColorPalette.white1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: SvgPicture.asset(
                  MainIcons.menu,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                Strings.tasks,
                style: TextStyles.header3.copyWith(color: ColorPalette.black1),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdvertisementScreen()));
                },
                child: Container(child: SvgPicture.asset(MainIcons.brilliant)),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: BlocBuilder<AlertcubitCubit, AlertcubitState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DateWidget(),
                  const SizedBox(height: 20),
                  CategoriesListRow(),
                  const SizedBox(height: 20),
                  TaskListWidget(),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: DraggableFab(
        // initPosition: Offset(200,200),
        child: Padding(
          padding: EdgeInsets.only(bottom: 30, right: 18),
          child: FloatingActionButton(
            // elevation: 20,
            backgroundColor: ColorPalette.purple1,
            onPressed: () {
            
            //  reminderAlert(context);
      
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Wrap(
                      children: [
                        BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: TaskBottomSheet()),
                      ],
                    );
                  });
            },
            child: SvgPicture.asset(MainIcons.plus),
          ),
        ),
      ),
    );
  }

  Future<String?> reminderAlert(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Reminder',
          textAlign: TextAlign.center,
        ),
        content: Container(height: 160,
          child: Column(
            children: [
              const Text(
                'Task "Conference in ZOOM" starts in 5 minutes',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25,),
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
}
