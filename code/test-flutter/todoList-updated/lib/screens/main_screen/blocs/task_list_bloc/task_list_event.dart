part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class TaskListInitialEvent extends TaskListEvent {}

class TaskListLoadEvent extends TaskListEvent {}

class AddTaskEvent extends TaskListEvent {
  final TaskModel task;
  AddTaskEvent({required this.task});
}

class RemoveTaskEvent extends TaskListEvent {
  final TaskModel task;
  RemoveTaskEvent({required this.task});
}

class EditTaskEvent extends TaskListEvent {
  final TaskModel task;
  EditTaskEvent({required this.task});
}
class ChangeTaskDone extends TaskListEvent {
  final TaskModel task;

  ChangeTaskDone({required this.task});
}
