import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider1.dart';
import 'package:todoapp/widget/tasklist.dart';

class AllTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, DBProvider value, child) {
        return FutureBuilder<List<TaskModel>>(
          future: value.getAllTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<TaskModel> tasks = snapshot.data;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(tasks[index]);
                  },
                );
              } else {
                return Center(
                  child: Text('No Tasks Found'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}

class CompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, DBProvider value, child) {
        return FutureBuilder<List<TaskModel>>(
          future: value.getCompleteTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<TaskModel> tasks = snapshot.data;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(tasks[index]);
                  },
                );
              } else {
                return Center(
                  child: Text('No Tasks Found'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}

class InCompleteTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, DBProvider value, child) {
        return FutureBuilder<List<TaskModel>>(
          future: value.getInCompleteTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<TaskModel> tasks = snapshot.data;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(tasks[index]);
                  },
                );
              } else {
                return Center(
                  child: Text('No Tasks Found'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }
}
