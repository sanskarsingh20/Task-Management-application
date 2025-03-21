import 'package:flutter/material.dart';
import 'package:task_manager_app/screen/Homescreen.dart';

import 'package:task_manager_app/management/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager App ',
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomeScreen(),
      ),
    );
  }
}
