part of 'timechange_cubit.dart';

abstract class TimechangeState extends Equatable {
  const TimechangeState();

  @override
  List<Object> get props => [];
}

class TimechangeInitial extends TimechangeState {}

class TimeChange extends TimechangeState {
  final newTime;
  final reminderTime;
  TimeChange({this.newTime, this.reminderTime});
}
