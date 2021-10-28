part of 'goal_list_bloc.dart';

@immutable
abstract class GoalListEvent {}

class GoalListInitialEvent extends GoalListEvent {}

class GoalListLoadEvent extends GoalListEvent {}

class AddGoalEvent extends GoalListEvent {
  final GoalModel goal;
  AddGoalEvent({required this.goal});
}

class RemoveGoalEvent extends GoalListEvent {
  final GoalModel goal;
  RemoveGoalEvent({required this.goal});
}
class EditGoalEvent extends GoalListEvent {
  final GoalModel goal;
  EditGoalEvent({required this.goal});
}

class ChangeGoalDone extends GoalListEvent {
  final GoalModel goal;

  ChangeGoalDone({required this.goal});
}
