import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/provider1.dart';
//import 'package:wac_todo_db/constants.dart';
//import 'package:wac_todo_db/models/task_model.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbinstance = DBHelper._();
  Database database;

  Future<Database> initDb() async {
    if (database == null) {
      database = await connectToDb();
      return database;
    } else {
      return database;
    }
  }

  Future<Database> connectToDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String dbPath = join(appDocPath, dbName);
    Database db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''create table $tableName(
          $columId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columTaskTitle TEXT NOT NULL,
          $columTaskdiscrption TEXT NOT NULL,
          $columTaskComplete INTEGER NOT NULL
        )''');
      },
    );
    return db;
  }

  insertNewTask(TaskModel taskModel) async {
    database = await initDb();
    database.insert(tableName, taskModel.toJson());
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    database = await initDb();
    List<Map<String, dynamic>> response = await database.query(tableName);
    return response;
  }

  getCompletedData() async {
    database = await initDb();
    List<Map<String, dynamic>> response = await database
        .query(tableName, where: '$columTaskComplete = ?', whereArgs: [1]);
    return response;
  }

  getInCompletedData() async {
    database = await initDb();
    List<Map<String, dynamic>> response = await database
        .query(tableName, where: '$columTaskComplete = ?', whereArgs: [0]);
    return response;
  }

  updateTask(TaskModel taskModel) async {
    database = await initDb();
    database.update(tableName, taskModel.toJson(),
        where: '$columId = ?', whereArgs: [taskModel.taskId]);
  }

  deleteTask(TaskModel taskModel) async {
    database = await initDb();
    database.delete(tableName,
        where: '$columId = ?', whereArgs: [taskModel.taskId]);
  }

  deleteAllTasks() async {
    database = await initDb();
    database.delete(tableName);
  }
}
