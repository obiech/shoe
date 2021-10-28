import 'package:get_it/get_it.dart';
import 'package:to_do_list_pro_project/data/data_source/category_data.dart';
import 'package:to_do_list_pro_project/data/data_source/goal_list_data.dart';
import 'package:to_do_list_pro_project/data/data_source/tariff_data.dart';
import 'package:to_do_list_pro_project/data/data_source/task_list_data.dart';
import 'package:to_do_list_pro_project/data/repositories/category_repo.dart';
import 'package:to_do_list_pro_project/data/repositories/goal_list_repo.dart';
import 'package:to_do_list_pro_project/data/repositories/tariff_repo.dart';
import 'package:to_do_list_pro_project/data/repositories/task_list_repo.dart';

final getIt = GetIt.instance;

void setupInjections() {
  //Data
  getIt.registerLazySingleton<TariffData>(() => TariffData());
  getIt.registerLazySingleton<TariffRepo>(() => TariffRepo(getIt()));

  // getIt.registerLazySingleton<TaskListData>(() => TaskListData());
  // getIt.registerLazySingleton<TaskListRepo>(() => TaskListRepo(getIt()));

  getIt.registerLazySingleton<CategoryData>(() => CategoryData());
  getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepo(getIt()));

  getIt.registerLazySingleton<GoalListData>(() => GoalListData());
  getIt.registerLazySingleton<GoalListRepo>(() => GoalListRepo(getIt()));
}
