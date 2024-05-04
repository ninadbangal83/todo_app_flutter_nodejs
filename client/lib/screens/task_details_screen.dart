import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'create_edit_task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int taskNumber;
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final bool isCompleted;

  const TaskDetailsScreen(
      {super.key,
      required this.taskNumber,
      required this.isCompleted,
      required this.taskTitle,
      required this.taskDescription,
      required this.taskId});

  @override
  Widget build(BuildContext context) {
    // Fetch task details based on task number from your data source
    // For now, displaying a simple scaffold with task details
    return Scaffold(
      appBar: AppBar(
        title: Text('Task $taskNumber - $taskTitle'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isCompleted
                  ? const Icon(
                      Icons.check_circle,
                      size: 100,
                      color: Colors.green,
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Description - $taskDescription',
                      // Replace with actual description
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateEditTaskScreen(
                        title: "Edit Task",
                        btnText: "Save",
                        taskId: taskId,
                        taskTitle: taskTitle,
                        taskDescription: taskDescription,
                        taskStatus: isCompleted,
                      )),
            );
          },
          backgroundColor: Colors.blue,
          shape: const CircleBorder(), // Set button color to blue
          child: const Icon(Icons.edit),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
