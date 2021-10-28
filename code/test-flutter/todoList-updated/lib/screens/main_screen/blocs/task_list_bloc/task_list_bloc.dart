import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';
import 'package:to_do_list_pro_project/data/repositories/task_list_repo.dart';
import 'package:to_do_list_pro_project/database/squlite.dart';
import 'package:to_do_list_pro_project/utils/helper.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc() : super(TaskListInitial());

  // TaskListRepo taskListRepo;
  DbHelper db = DbHelper();
  Helper helper = Helper();

  @override
  Stream<TaskListState> mapEventToState(
    TaskListEvent event,
  ) async* {
    if (event is TaskListInitialEvent) {
      yield TaskListInitial();
    }
    if (event is TaskListLoadEvent) {
      yield TaskListLoading();
      try {
        yield TaskListLoaded(
          currentTasks: await db.getDocsTask().then((value) =>
              value.where((element) => !element.isCompleted!).toList()),
          completedTasks: await db.getDocsTask().then((value) =>
              value.where((element) => element.isCompleted!).toList()),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
    if (event is AddTaskEvent) {
      yield TaskListLoading();
      try {
        await db.insertDoc(name: 'task', model: event.task);
        yield TaskListLoaded(
          currentTasks: await db.getDocsTask().then((value) =>
              value.where((element) => !element.isCompleted!).toList()),
          completedTasks: await db.getDocsTask().then((value) =>
              value.where((element) => element.isCompleted!).toList()),
        );
      } catch (e) {
        print(e.toString());
        yield TaskListError();
      }
    }
    if (event is EditTaskEvent){
      yield TaskListLoading();
      try {
        await db.updateDoc(model: event.task, name: 'task');
        yield TaskListLoaded(
          currentTasks: await db.getDocsTask().then((value) =>
              value.where((element) => !element.isCompleted!).toList()),
          completedTasks: await db.getDocsTask().then((value) =>
              value.where((element) => element.isCompleted!).toList()),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
    if (event is RemoveTaskEvent) {
      yield TaskListLoading();
      try {
        await db.deleteDoc(id: event.task.id!, name: 'task');
        yield TaskListLoaded(
          currentTasks: await db.getDocsTask().then((value) =>
              value.where((element) => !element.isCompleted!).toList()),
          completedTasks: await db.getDocsTask().then((value) =>
              value.where((element) => element.isCompleted!).toList()),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
    if (event is ChangeTaskDone) {
      yield TaskListLoading();

      try {
        await db.updateDoc(model: event.task, name: 'task');
        yield TaskListLoaded(
          currentTasks: await db.getDocsTask().then((value) =>
              value.where((element) => !element.isCompleted!).toList()),
          completedTasks: await db.getDocsTask().then((value) =>
              value.where((element) => element.isCompleted!).toList()),
        );
      } catch (e) {
        e.toString();
        yield TaskListError();
      }
    }
  }
}
