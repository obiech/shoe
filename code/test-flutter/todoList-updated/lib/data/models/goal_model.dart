import 'package:flutter/material.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';

class GoalModel {
  int? isCompleted;
  String? title;
  String? calendar;
  String? category;
  int? isRemind;
  int? id;
  int? term;
  // int? time;


   @override
  bool operator ==(Object other) => (other is GoalModel) && id == other.id;

  @override
  int get hashCode => id.hashCode;

  GoalModel(
      {required this.title,
      required this.calendar,
      required this.category,
      required this.isRemind,
      required this.isCompleted,
      required this.term,
       this.id});


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'calendar': calendar,
      'category': category,
      'isRemind': isRemind,
      'term': term,
      'id': id,
    };
  }

  GoalModel.fromOject(dynamic o, int index) {
    this.title = o[index]["title"];
    this.isCompleted = o[index]["isCompleted"];
    this.calendar = o[index]["calendar"];
    this.category = o[index]['category'];
    this.isRemind = o[index]["isRemind"];
    this.term = o[index]["term"];
    this.id = o[index]['id'];
  }
}
