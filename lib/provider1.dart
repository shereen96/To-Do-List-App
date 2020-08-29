import 'package:flutter/material.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/database.dart';

class DBProvider extends ChangeNotifier {
  Future<List<TaskModel>> getAllTasks() async {
    List<Map<String, dynamic>> allTasks =
        await DBHelper.dbinstance.getAllTasks();
    List<TaskModel> tasks = allTasks.map((e) => TaskModel.frmJson(e)).toList();
    return tasks;
  }

  Future<List<TaskModel>> getCompleteTasks() async {
    List<Map<String, dynamic>> allTasks =
        await DBHelper.dbinstance.getCompletedData();
    List<TaskModel> tasks = allTasks.map((e) => TaskModel.frmJson(e)).toList();
    return tasks;
  }

  Future<List<TaskModel>> getInCompleteTasks() async {
    List<Map<String, dynamic>> allTasks =
        await DBHelper.dbinstance.getInCompletedData();
    List<TaskModel> tasks = allTasks.map((e) => TaskModel.frmJson(e)).toList();
    return tasks;
  }

  excuteAllMethods() {
    getAllTasks();
    getCompleteTasks();
    getInCompleteTasks();
    notifyListeners();
  }

  insertNewData(TaskModel taskModel) async {
    await DBHelper.dbinstance.insertNewTask(taskModel);
    excuteAllMethods();
  }

  updateTask(TaskModel taskModel) async {
    taskModel.toggleComplete();
    await DBHelper.dbinstance.updateTask(taskModel);
    excuteAllMethods();
  }

  deleteTask(TaskModel taskModel) async {
    await DBHelper.dbinstance.deleteTask(taskModel);
    excuteAllMethods();
  }
}

class TaskModel {
  int taskId;
  String taskTitle;
  String taskdiscrption;
  bool isComplete;
  TaskModel(this.taskTitle, this.isComplete, this.taskdiscrption);

  TaskModel.frmJson(Map<String, dynamic> map) {
    this.taskId = map[columId];
    this.taskTitle = map[columTaskTitle];
    this.taskdiscrption = map[columTaskdiscrption];
    this.isComplete = map[columTaskComplete] == 1 ? true : false;
  }

  toJson() {
    return {
      columTaskTitle: this.taskTitle,
      columTaskdiscrption: this.taskdiscrption,
      columTaskComplete: this.isComplete ? 1 : 0
    };
  }

  toggleComplete() {
    isComplete = !isComplete;
  }
}
