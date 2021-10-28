import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:flutter/material.dart';

class GoalListData {
  List<GoalModel> _goals = [
    // GoalModel(
    //   indicatorColor: Colors.red,
    //   title: 'Конференция в ZOOM',
    //   category: 'Работа',
    //   isRepeatable: true,
    //   isRemind: true,
    //   repeatDays: 5,
    //   // subtasks: [],
    //   isCompleted: false,
    //   remindDate: '20210527', calendar: null,
    // ),
    // GoalModel(
    //   indicatorColor: Colors.red,
    //   title: 'Купить подарок сестре',
    //   category: 'Семья',
    //   isRepeatable: false,
    //   isRemind: true,
    //   repeatDays: 3,
    //   // subtasks: [],
    //   isCompleted: false,
    // ),
    // GoalModel(
    //   indicatorColor: Colors.red,
    //   title: 'Выгулять собаку',
    //   category: 'Дом',
    //   isRepeatable: false,
    //   isRemind: false,
    //   repeatDays: 4,
    //   // subtasks: _subtasks,
    //   isCompleted: false,
    // ),
    // GoalModel(
    //   indicatorColor: Colors.red,
    //   title: 'Купить футболку',
    //   category: 'Покупки',
    //   isRepeatable: false,
    //   repeatDays: 7,
    //   isRemind: false,
    //   // subtasks: [],
    //   isCompleted: true,
    // ),
  ];

  List<GoalModel> get goals => _goals;

  void addGoal(GoalModel goal) {
    _goals.add(goal);
  }

  void removeGoal(GoalModel goal) {
    _goals.remove(goal);
  }

  // static List<SubTask> _subtasks = [
  //   SubTask(
  //     title: 'По дороге зайти в магазин',
  //     isCompleted: false,
  //   ),
  //   SubTask(
  //     title: 'Зайти в аптеку',
  //     isCompleted: true,
  //   ),
  // ];
}
