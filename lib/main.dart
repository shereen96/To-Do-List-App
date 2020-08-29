import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider1.dart';
import 'package:todoapp/screens/mainscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DBProvider>(
      create: (context) => DBProvider(),
      child: MaterialApp(
        home: TaskHome(),
      ),
    );
  }
}
