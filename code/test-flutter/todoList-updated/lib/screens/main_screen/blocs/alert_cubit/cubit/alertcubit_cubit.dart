import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_list_pro_project/utils/helper.dart';

part 'alertcubit_state.dart';

class AlertcubitCubit extends Cubit<AlertcubitState> {
  Helper helper = Helper();

  AlertcubitCubit() : super(AlertcubitInitial());

  void check(BuildContext context, DateTime a, bool isFirst, DateTime b) {
    // if (helper.showAlert(context, a, isFirst)) {
    //   var diff = helper.differenceTime(a, b);
    //   emit(AlertcubitShow(diff));
    // }
  }
}
