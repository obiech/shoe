part of 'goal_list_bloc.dart';

abstract class GoalListState extends Equatable {
  const GoalListState();

  @override
  List<Object> get props => [];
}

class GoalListInitial extends GoalListState {
  @override
  List<Object> get props => [];
}

class GoalListLoading extends GoalListState {
  @override
  List<Object> get props => [];
}

class GoalListLoaded extends GoalListState {
  final List<GoalModel> currentGoals;
  final List<GoalModel> completedGoals;
  final List<GoalModel> shortTerm;
  final List<GoalModel> mediumTerm;
  final List<GoalModel> longTerm;

  GoalListLoaded(
      {required this.currentGoals,
      required this.completedGoals,
      required this.shortTerm,
        required this.mediumTerm,
        required this.longTerm
      });

  @override
  List<Object> get props => [currentGoals, completedGoals];
}

class GoalListError extends GoalListState {
  @override
  List<Object> get props => [];
}
