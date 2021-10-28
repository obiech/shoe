part of 'alertcubit_cubit.dart';

abstract class AlertcubitState extends Equatable {
  const AlertcubitState();

  @override
  List<Object> get props => [];
}

class AlertcubitInitial extends AlertcubitState {}

class AlertcubitShow extends AlertcubitState{
  final time;

  AlertcubitShow(this.time);
  
}
