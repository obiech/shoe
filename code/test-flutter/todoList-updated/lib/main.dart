// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:to_do_list_pro_project/screens/advertisement_screen/screen.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/alert_cubit/cubit/alertcubit_cubit.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/category_list_bloc/category_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/goal_list_bloc/goal_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/task_list_bloc/task_list_bloc.dart';
import 'package:to_do_list_pro_project/screens/main_screen/blocs/time_cubit/timechange_cubit.dart';
import 'package:to_do_list_pro_project/screens/main_screen/screen.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/bottom_nav_bar_widget.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/savchits.dart';
import 'package:to_do_list_pro_project/screens/welcome.dart';
import 'package:to_do_list_pro_project/utils/injection_container.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

void main() {
  setupInjections();
  initializeDateFormatting('ru');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    global.store.set('categoryName', 'All');
    global.store.set('selectedDate', DateTime.now());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskListBloc()),
        BlocProvider(
            create: (context) =>
                CategoryListBloc(getIt())..add(CategoryListLoadEvent())),
        BlocProvider(
            create: (context) =>
                GoalListBloc(goalListRepo: getIt())..add(GoalListLoadEvent())),
        BlocProvider(create: (context) => TimechangeCubit()),
        BlocProvider(create: (context) => AlertcubitCubit()),
      ],
      child: MaterialApp(
        title: 'To Do List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Mont',
        ),
        home: SavchitsPage(),
      ),
    );
  }
}
