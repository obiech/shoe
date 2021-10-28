import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/repositories/goal_list_repo.dart';
import 'package:to_do_list_pro_project/database/squlite.dart';
// import 'package:to_do_list_pro_project/screens/main_screen/widgets/database/squlite.dart';
import 'package:to_do_list_pro_project/utils/helper.dart';

part 'goal_list_event.dart';
part 'goal_list_state.dart';

class GoalListBloc extends Bloc<GoalListEvent, GoalListState> {
  GoalListBloc({required this.goalListRepo}) : super(GoalListInitial());

  GoalListRepo goalListRepo;
  DbHelper db = DbHelper();
  Helper helper = Helper();

  @override
  Stream<GoalListState> mapEventToState(
    GoalListEvent event,
  ) async* {
    if (event is GoalListInitialEvent) {
      yield GoalListInitial();
    }
    if (event is GoalListLoadEvent) {
      yield GoalListLoading();
      try {
        yield GoalListLoaded(
            currentGoals: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).toList()),
            completedGoals: await db.getDocs().then((value) =>
                value.where((element) => !helper.convertIntToBool(element.isCompleted!)).toList()),
            shortTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! < 30).toList()),
            mediumTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 30 && element.term! < 180).toList()),
            longTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 180).toList()));
        // )
        // );
      } catch (e) {
        e.toString();
        yield GoalListError();
      }
    }
    if (event is AddGoalEvent) {
      yield GoalListLoading();
      try {
        db.insertDoc(name: 'goal', model:event.goal);
        yield GoalListLoaded(
            currentGoals: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).toList()),
            completedGoals: await db.getDocs().then((value) =>
                value.where((element) => !helper.convertIntToBool(element.isCompleted!)).toList()),
            shortTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! < 30).toList()),
            mediumTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 30 && element.term! < 180).toList()),
            longTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 180).toList()));
        var a =await db.getDocs().then((value) =>
            value.where((element) => helper.convertIntToBool(element.isCompleted!)));

        log(a.toString(), name: 'longterm');
      } catch (e) {
        e.toString();
        yield GoalListError();
      }
    }
    if (event is RemoveGoalEvent) {
      yield GoalListLoading();
      try {
        db.deleteDoc(id:event.goal.id!, name: 'goal');
        yield GoalListLoaded(
          currentGoals: await db.getDocs().then((value) =>
              value.where((element) => !helper.convertIntToBool(element.isCompleted!)).toList()),
          completedGoals: await db.getDocs().then((value) =>
              value.where((element) => helper.convertIntToBool(element.isCompleted!)).toList()),
            shortTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! < 30).toList()),
            mediumTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 30 && element.term! < 180).toList()),
            longTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 180).toList(),
        ));
      } catch (e) {
        e.toString();
        yield GoalListError();
      }
    }
    if (event is EditGoalEvent) {
       yield GoalListLoading();
      try {
        db.updateDoc(model:event.goal, name:'goal');
        // db.insertDoc(model:event.goal..isCompleted = (event.goal.isCompleted!), name: 'goal');
        yield GoalListLoaded(
          currentGoals: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).toList()),
            completedGoals: await db.getDocs().then((value) =>
                value.where((element) => !helper.convertIntToBool(element.isCompleted!)).toList()),
            shortTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! < 30).toList()),
            mediumTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 30 && element.term! < 180).toList()),
            longTerm: await db.getDocs().then((value) =>
                value.where((element) => helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 180).toList()));
        var a =await db.getDocs().then((value) =>
            value.where((element) => helper.convertIntToBool(element.isCompleted!)));
        
      } catch (e) {
        e.toString();
        yield GoalListError();
      }
    }
    if (event is ChangeGoalDone) {
       yield GoalListLoading();
      try {
        db.deleteDoc(id:event.goal.id!, name:'goal');
        db.insertDoc(model:event.goal..isCompleted = (event.goal.isCompleted!), name: 'goal');
        yield GoalListLoaded(
          currentGoals: await db.getDocs().then((value) =>
              value.where((element) => !helper.convertIntToBool(element.isCompleted!)).toList()),
          completedGoals: await db.getDocs().then((value) =>
              value.where((element) => helper.convertIntToBool(element.isCompleted!)).toList()),
            shortTerm: await db.getDocs().then((value) =>
                value.where((element) => !helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! < 30).toList()),
            mediumTerm: await db.getDocs().then((value) =>
                value.where((element) => !helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 30 && element.term! < 180).toList()),
            longTerm: await db.getDocs().then((value) =>
                value.where((element) => !helper.convertIntToBool(element.isCompleted!)).where((element) => element.term! > 180).toList(),
        ));
      } catch (e) {
        e.toString();
        yield GoalListError();
      }
    }
  }
}
