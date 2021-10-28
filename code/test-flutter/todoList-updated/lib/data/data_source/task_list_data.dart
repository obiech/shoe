// import 'package:to_do_list_pro_project/data/models/task_model.dart';
// import 'package:flutter/material.dart';

// class TaskListData {
//   List<TaskModel> _tasks = [
//     TaskModel(
//       indicatorColor: Colors.red,
//       title: 'Конференция в ZOOM',
//       category: 'Работа',
//       isRepeatable: true,
//       isRemind: true,
//       repeatDays: 5,
//       subtasks: [],
//       isCompleted: false,
//       remindDate: '20210527',
//     ),
//     TaskModel(
//       indicatorColor: Colors.red,
//       title: 'Купить подарок сестре',
//       category: 'Семья',
//       isRepeatable: false,
//       isRemind: true,
//       repeatDays: 3,
//       subtasks: [],
//       isCompleted: false,
//     ),
//     TaskModel(
//       indicatorColor: Colors.red,
//       title: 'Выгулять собаку',
//       category: 'Дом',
//       isRepeatable: false,
//       isRemind: false,
//       repeatDays: 4,
//       subtasks: _subtasks,
//       isCompleted: false,
//     ),
//     TaskModel(
//       indicatorColor: Colors.red,
//       title: 'Купить футболку',
//       category: 'Покупки',
//       isRepeatable: false,
//       repeatDays: 7,
//       isRemind: false,
//       subtasks: [],
//       isCompleted: true,
//     ),
//   ];

//   List<TaskModel> get tasks => _tasks;

//   void addTask(TaskModel task) {
//     _tasks.add(task);
//   }

//   void removeTask(TaskModel task) {
//     _tasks.remove(task);
//   }

//   static List<SubTask> _subtasks = [
//     SubTask(
//       title: 'По дороге зайти в магазин',
//       isCompleted: false,
//     ),
//     SubTask(
//       title: 'Зайти в аптеку',
//       isCompleted: true,
//     ),
//   ];
// }
