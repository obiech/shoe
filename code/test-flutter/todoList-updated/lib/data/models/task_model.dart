import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_list_pro_project/utils/helper.dart';

class TaskModel {
  int? indicatorColor;
  String? title;
  String? category;
  bool? isRepeatable;
  DateTime? repeatDays;
  bool? isRemind;
  bool? isCompleted;
  List? subtasks;
  int? id;
  DateTime? remindDate;

  Helper helper = Helper();

  TaskModel({
    required this.indicatorColor,
    required this.title,
    required this.repeatDays,
    required this.category,
    required this.isRepeatable,
    required this.isRemind,
    required this.subtasks,
    required this.isCompleted,
    this.remindDate,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': helper.convertBoolToInt(isCompleted!),
      'indicatorColor': indicatorColor,
      'category': category,
      'id': id,
      'isRemind': helper.convertBoolToInt(isRemind!),
      'repeatDays': repeatDays.toString(),
      'isRepeatable': helper.convertBoolToInt(isRepeatable!),
      'subtasks': jsonEncode(subtasks),
      'remindDate': remindDate.toString(),
    };
  }

  TaskModel.fromOject(dynamic o, int index) {
    this.title = o[index]["title"];
    this.isCompleted = helper.convertIntToBool(o[index]["isCompleted"]);
    this.indicatorColor = o[index]["indicatorColor"];
    // o[index]["indicatorColor"];
    this.category = o[index]['category'];
    this.id = o[index]['id'];
    this.isRemind = helper.convertIntToBool(o[index]["isRemind"]);
    this.repeatDays =DateTime.parse(o[index]["repeatDays"]);
    this.isRepeatable = helper.convertIntToBool(o[index]["isRepeatable"]);
    List a = jsonDecode(o[index]["subtasks"]);
    print(jsonDecode(o[index]["subtasks"])
        .map((e) => SubTask.fromJson(e))
        .toList());
    this.subtasks = jsonDecode(o[index]["subtasks"])
        .map((e) => SubTask.fromJson(e))
        .toList();
    this.remindDate =DateTime.parse(o[index]["remindDate"]);
  }
  Map toJson() => {
        'subtasks': subtasks,
        'isCompleted': isCompleted,
      };
}

class SubTask {
  String title;
  bool? isCompleted;

  SubTask({
    required this.title,
    this.isCompleted = false,
  });

  Map toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };

  factory SubTask.fromJson(dynamic json) {
    return SubTask(
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
