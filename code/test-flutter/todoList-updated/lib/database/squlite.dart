import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_list_pro_project/data/data_source/category_data.dart';
import 'package:to_do_list_pro_project/data/models/category_model.dart';
import 'package:to_do_list_pro_project/data/models/goal_model.dart';
import 'package:to_do_list_pro_project/data/models/task_model.dart';

class DbHelper {
  GoalModel? goalModel;
  static final DbHelper _dbHelper = DbHelper._internal();

  var tblDocs = 'goal';
  var docId = 'id';
  var title = 'title';
  var category = 'category';
  var calendar = 'calendar';
  var isRemind = 'isRemind';
  var isCompleted = 'isCompleted';
  var term = 'term';

  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }
  // Database entry point.
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory d = await getApplicationDocumentsDirectory();
    String p = d.path + "/docexpire.db";
    var db = await openDatabase(p, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tblDocs($docId INTEGER PRIMARY KEY, $title TEXT, " +
            "$calendar TEXT, $category TEXT, $isCompleted INTEGER, $isRemind INTEGER, $term INTEGER)");
    await db.execute(
        "CREATE TABLE category(id INTEGER PRIMARY KEY, title TEXT, " +
            "color INTEGER)");
    await db.execute("CREATE TABLE task(id INTEGER PRIMARY KEY, title TEXT, " +
        "indicatorColor INTEGER,repeatDays INTEGER,category TEXT, isRepeatable INTEGER, " +
        "isRemind INTEGER,isCompleted INTEGER, remindDate TEXT, subtasks TEXT )");
    await db.insert('category', {'title': 'All', 'color': 1});
  }

  Future insertDoc({required String name, required final model}) async {
    var r;
    Database? db = await this.db;
    try {
      r = await db!.insert(name, model.toMap());
    } catch (e) {
      print("insertDoc: " + e.toString());
    }
    print(r.toString() + 'obiec');
    return r;
  }

  Future<List<GoalModel>> getDocs() async {
    Database? db = await this.db;
    var r = await db!.rawQuery("SELECT * FROM $tblDocs ORDER BY $docId ASC");
    print(r.toString() + 'asdfq');
    return List.generate(r.length, (index) {
      return GoalModel.fromOject(r, index);
    });
  }

  Future<List<CategoryModel>> getDocsCategory() async {
    Database? db = await this.db;
    var r = await db!.rawQuery("SELECT * FROM category ORDER BY $docId ASC");
    print(r.toString() + 'asdfq');
    return List.generate(r.length, (index) {
      return CategoryModel.fromOject(r, index);
    });
  }

  Future<List<TaskModel>> getDocsTask() async {
    Database? db = await this.db;
    var r = await db!.rawQuery("SELECT * FROM task ORDER BY $docId ASC");
    print(r.toString() + 'asdfq');
    return List.generate(r.length, (index) {
      return TaskModel.fromOject(r, index);
    });
  }

  Future<int> deleteDoc({required int id, required String name}) async {
    var db = await this.db;
    int r = await db!.rawDelete("DELETE FROM $name WHERE $docId = $id");
    print(r.toString() + 'qwe');
    return r;
  }

  Future<int> updateDoc({
    required final model,
    required String name,
  }) async {
    var db = await this.db;
    var r;
    try {
      r = await db!.update(name, model.toMap(),
          where: "$docId = ?", whereArgs: [model.id]);
      return r;
    } catch (e) {
      print(e.toString());
      // return r;
    }
    return r;
  }
}
