import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/management/provider.dart';
import 'package:task_manager_app/data/taskmodel.dart';

class AddTask extends StatefulWidget {
  final Taskmodel? task;
  final int? index;

  AddTask({this.task, this.index});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final FocusNode _taskFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _taskController.text = widget.task!.title;
      _descController.text = widget.task!.description;
    }
    _taskController.addListener(_checkFields);
    _descController.addListener(_checkFields);
    _checkFields();
  }

  void _checkFields() {
    setState(() {
      _isButtonEnabled =
          _taskController.text.trim().isNotEmpty &&
          _descController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descController.dispose();
    _taskFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      constraints: BoxConstraints(maxWidth: 350),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task == null ? 'Add New Task' : 'Edit Task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          _buildTextField(
            _taskController,
            'Task Title',
            focusNode: _taskFocus,
            nextFocus: _descFocus,
          ),
          SizedBox(height: 12),
          _buildTextField(
            _descController,
            'Task Description',
            focusNode: _descFocus,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed:
                  _isButtonEnabled
                      ? () {
                        String taskTitle = _taskController.text.trim();
                        String taskDescription = _descController.text.trim();

                        if (taskTitle.isNotEmpty &&
                            taskDescription.isNotEmpty) {
                          if (widget.task == null) {
                            Provider.of<TaskProvider>(
                              context,
                              listen: false,
                            ).addTask(taskTitle, taskDescription);
                          } else {
                            Provider.of<TaskProvider>(
                              context,
                              listen: false,
                            ).editTask(
                              widget.index!,
                              taskTitle,
                              taskDescription,
                            );
                          }
                          Navigator.pop(context);
                        }
                      }
                      : null,
              icon: Icon(
                widget.task == null ? Icons.add : Icons.edit,
                color: Colors.white,
              ),
              label: Text(
                widget.task == null ? 'Add' : 'Update',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isButtonEnabled ? Colors.green : Colors.grey[700],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    FocusNode? focusNode,
    FocusNode? nextFocus,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      focusNode: focusNode,
      textInputAction: textInputAction,
      style: TextStyle(color: Colors.white),
      onSubmitted: (_) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
      ),
    );
  }
}
