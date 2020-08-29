import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider1.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;
  TaskItem(this.taskModel);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.yellow,
        child: Dismissible(
          key: ObjectKey(taskModel),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              Provider.of<DBProvider>(context, listen: false)
                  .deleteTask(taskModel);
            }
          },
          background: Container(
            color: Colors.red,
          ),
          child: ListTile(
            leading: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Provider.of<DBProvider>(context, listen: false)
                  //     .deleteTask(taskModel);
                }),
            title: Text(taskModel.taskTitle),
            subtitle: Text(taskModel.taskdiscrption),
            trailing: Checkbox(
              value: taskModel.isComplete,
              onChanged: (value) {
                Provider.of<DBProvider>(context, listen: false)
                    .updateTask(taskModel);
              },
            ),
          ),
        ));
  }
}
