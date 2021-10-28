part of 'task_list_bloc.dart';

abstract class TaskListState extends Equatable {
  const TaskListState();

  @override
  List<Object> get props => [];
}

class TaskListInitial extends TaskListState {
  @override
  List<Object> get props => [];
}

class TaskListLoading extends TaskListState {
  @override
  List<Object> get props => [];
}

class TaskListLoaded extends TaskListState {
  final List<TaskModel> currentTasks;
  final List<TaskModel> completedTasks;

  TaskListLoaded({required this.currentTasks, required this.completedTasks});

  @override
  List<Object> get props => [currentTasks, completedTasks];
}

class TaskListError extends TaskListState {
  @override
  List<Object> get props => [];
}
