import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider1.dart';
import 'package:todoapp/widget/list.dart';

class TaskHome extends StatelessWidget {
  String newTaskTile;
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.brown,
            title: Text('TODO APP'),
          ),
          body: AllTasks(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.add, color: Colors.brown),
              onPressed: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.brown,
                      title: Text('Add  New Task'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      labelText: 'task name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                                SizedBox(
                                  height: 5,
                                  width: 5,
                                ),
                                TextField(
                                  controller: controller1,
                                  decoration: InputDecoration(
                                      labelText: 'descrption',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.done_all, color: Colors.green),
                          onPressed: () {
                            TaskModel taskModel = TaskModel(
                                controller.text, false, controller1.text);
                            Provider.of<DBProvider>(context, listen: false)
                                .insertNewData(taskModel);
                            controller.clear();
                            controller1.clear();
                            //   Navigator.of(context).pop();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              }),
          bottomNavigationBar: BottomAppBar(
            color: Colors.brown,
//color: Color(0xff2da9ef),
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.check_box,
                      color: Colors.greenAccent,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Container(
                                child: Column(children: <Widget>[
                              Container(
                                // height: 300,
                                // width: 150,
                                width: MediaQuery.of(context).size.width - 10,
                                height: MediaQuery.of(context).size.height - 80,
                                padding: EdgeInsets.all(20),
                                color: Colors.white,
                                child: CompleteTasks(),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  // height:
                                  //     MediaQuery.of(context).size.height - 80,
                                  //     padding: EdgeInsets.all(20),
                                  color: Colors.white,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      " Completed Task",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.green,
                                    // color: const Color(0xFF1BC0C5),
                                  ))
                            ]));
                          });
                    }),
                IconButton(
                  icon: Icon(
                    Icons.warning,
                    color: Colors.redAccent,
                  ),
                  color: Colors.red,
                  onPressed: () {
                    showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        barrierColor: Colors.black45,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext buildContext,
                            Animation animation, Animation secondaryAnimation) {
                          return Container(
                              child: Column(children: <Widget>[
                            Container(
                              // height: 300,
                              // width: 150,
                              width: MediaQuery.of(context).size.width - 10,
                              height: MediaQuery.of(context).size.height - 80,
                              padding: EdgeInsets.all(20),
                              color: Colors.white,
                              child: InCompleteTasks(),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 10,
                                // height:
                                //     MediaQuery.of(context).size.height - 80,
                                //     padding: EdgeInsets.all(20),
                                color: Colors.white,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Un Completed Task",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.red,
                                  //color: const Color(0xFF1BC0C5),
                                ))
                          ]));
                        });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
