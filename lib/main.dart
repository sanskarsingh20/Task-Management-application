import 'package:flutter/material.dart';
import 'package:task_manager_app/screen/Homescreen.dart';
import 'package:task_manager_app/management/provider.dart';
import 'package:provider/provider.dart';

 void main() 
 {
  // main function
    runApp(MyApp());
    // run the app
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
// constructor
  @override
  Widget build(BuildContext context) 
  // navigator function
  {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),

      // provider to main
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager App ',
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomeScreen(),
        // basic theme
      ),
    );
  }
}
