import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/database/squlite.dart';
import 'package:to_do_list_pro_project/utils/global_state.dart' as global;

class Helper {
  List<CategoryModel> categories = [];
  DbHelper db = DbHelper();

  bool convertIntToBool(int a) {
    if (a == 1) return true;
    return false;
  }

  int convertBoolToInt(bool a) {
    if (a == true) return 1;
    return 0;
  }
  // int convertDateTimeToDays(DateTime from dateTime to){
  //   DateTime.now()
  // }

  int daysBetween(String toString) {
    DateTime to = DateTime.parse(toString);
    // from = DateTime.now();
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
    return (to.difference(DateTime.now()).inHours).round();
  }

  Future<void> getCat() async {
    global.store.set('categoryList', null);
    categories = await db
        .getDocsCategory()
        .then((value) => value.map((e) => e).toList());
    global.store.set('categoryList', categories);
  }
  void getCatColor()async{
    global.store.set('categoryColor', null);
    var categoriesColor = await db
        .getDocsCategory()
        .then((value) => value.map((e) => e.color).toList());
    global.store.set('categoryColor', categoriesColor);
  }
  

  int differenceTime(DateTime a, DateTime b) {
    return a.difference(b).inMinutes;
  }

  bool showAlert( DateTime a, bool isFirst) {
    if (DateTime.now().difference(a).isNegative && isFirst) {
      return true;
    }
    return false;
  }
}
