import 'package:flutter/material.dart';
import 'package:task_manager_app/data/taskmodel.dart';        // Importing Task model
import 'package:task_manager_app/screen/addtask.dart';
import 'package:task_manager_app/management/provider.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/utils/shared_preference.dart';
import 'package:task_manager_app/screen/taskbox.dart';
class HomeScreen extends StatelessWidget {
  

  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Task Manager App'),
        centerTitle: true,

        //leading Widget for left side icon 

        leading: Builder(builder: (context) => IconButton(icon: Icon(Icons.menu),
        onPressed: ()=>Scaffold(),),),
        actions: [
          IconButton(
      icon: Icon(Icons.notifications),
          onPressed: (){
            print(("Notification Icon Clicked"));
          },)
        ],
      ),
      backgroundColor: Colors.white,

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    autocorrect: false,
                     //  AutoCorrect Disabled

                    decoration: InputDecoration(
                      hintText: 'Enter Task',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {

                    // if (_taskController.text.isNotEmpty) {
                    //   Provider.of<TaskProvider>(context, listen: false)
                    //       .addTask(_taskController.text);
                    //   _taskController.clear();
                    // }

                    // this is not working
                  },
                  
                  child: Text('Add'),
                ),
              ],
            ),
          ),
Expanded(
          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              TaskBox(title: "todo", color: Colors.green.shade700),
              SizedBox(height: 10),


              TaskBox(title:"inprogress" ,color: Colors.green.shade600),
              SizedBox(height: 10),
              TaskBox(title: "Completed",color: Colors.green,)
            ]),
          )),

          //  Task List
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                print("Total Tasks: ${taskProvider.tasks.length}");
                return taskProvider.tasks.isEmpty
                    ? Center(
                        child: Text(
                          'No tasks added yet!',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: taskProvider.tasks.length,
                        itemBuilder: (context, index) {
                          Taskmodel task = taskProvider.tasks[index]; 
                          
                          
                          return Card(
                            color: Color.fromARGB(255, 95, 106, 39),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                              
    //                           child: Container(
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(8),
    //   border: Border.all(color: Colors.green, width: 2), // Optional: Green border
    // ),
    // 
    //Exceptional thing:showing some error



                 child: ListTile(
                  title: Text(
                 task.title,
                style: TextStyle(color: Colors.white),),
                  subtitle:Text(task.description,style: TextStyle(color: Colors.white),),

                              
                              leading: Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) {
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .toggleTask(index);
                                },
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: () {
                                  Provider.of<TaskProvider>(context,
                                          listen: false)
                                      .deleteTask(index);
                                },
                              ),
                            ),
                          );
                        },
                      );
              },   ), ),
        ],
      ),



      // Floating Action Button
      
        
         

 floatingActionButton: FloatingActionButton(
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: AddTask(),
      ),
    );
  },
  child: Icon(Icons.add),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );}
    }