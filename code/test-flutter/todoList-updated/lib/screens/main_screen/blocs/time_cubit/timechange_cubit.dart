import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/expanded_settings.dart';

part 'timechange_state.dart';

class TimechangeCubit extends Cubit<TimechangeState> {
  TimechangeCubit()
      : super(
            TimeChange(newTime: DateTime.now(), reminderTime: DateTime.now()));

  void onTimeChange(newTime, reminderTime) {
    emit(TimechangeInitial());
    emit(TimeChange(newTime: newTime,reminderTime: reminderTime));
  }

}
