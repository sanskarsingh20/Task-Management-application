import 'package:flutter/material.dart';

// ✅ Custom Task Box Widget
class TaskBox extends StatelessWidget {
  final String title;
  final Color color;

  TaskBox({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "No tasks yet!", // ✅ Yahan pe tasks dynamically aa sakte hain
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
