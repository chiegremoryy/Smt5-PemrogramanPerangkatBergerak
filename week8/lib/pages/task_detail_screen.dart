import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${task.title}', style: TextStyle(fontSize: 18)),
            Text('Description: ${task.description}', style: TextStyle(fontSize: 18)),
            Text(
              'Status: ${task.isCompleted ? 'Completed' : 'Not Completed'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskScreen(task: task)),
                ).then((_) => Navigator.pop(context));
              },
              child: Text('Edit Task'),
            ),
          ],
        ),
      ),
    );
  }
}
