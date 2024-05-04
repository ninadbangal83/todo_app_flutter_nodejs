import 'package:flutter/material.dart';
import '../providers/task_provider.dart';
import '../screens/task_details_screen.dart';
import 'package:provider/provider.dart';

import '../utils/create_edit_tasks_handler.dart';
import '../utils/delete_task_handler.dart';

class TaskCard extends StatefulWidget {
  final String taskId;
  final int taskNumber;
  final String taskTitle;
  final String taskDescription;
  final bool isCompleted;
  final Function onDelete;

  const TaskCard({
    super.key,
    required this.taskId,
    required this.taskNumber,
    required this.taskTitle,
    required this.taskDescription,
    required this.isCompleted,
    required this.onDelete,
  });

  @override
  TaskCardState createState() => TaskCardState();
}

class TaskCardState extends State<TaskCard> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Building TaskCard for task ${widget.taskId}'); // Print statement to track rebuilds
    final currentContext = context;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                taskId: widget.taskId,
                taskNumber: widget.taskNumber,
                taskTitle: widget.taskTitle,
                taskDescription: widget.taskDescription,
                isCompleted: _isCompleted,
              ),
            ),
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Row(
            mainAxisAlignment: MediaQuery.of(context).size.width > 600
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text('${widget.taskNumber}. '), // Task number
              Expanded(
                child: Text(
                  widget.taskTitle, // Task title
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  _isCompleted ? Icons.check_circle : Icons.circle,
                  color: _isCompleted ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  final task = {"completed": !_isCompleted};
                  createEditTaskHandler(
                      currentContext, "bool", task, widget.taskId);

                  setState(() {
                    _isCompleted = !_isCompleted;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await deleteTaskHandler(currentContext, widget.taskId);
                  if (!currentContext.mounted) return;
                  widget.onDelete();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return FutureBuilder(
      future: taskProvider.fetchTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Show loading indicator while fetching tasks
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Consumer<TaskProvider>(
            builder: (context, taskProvider, _) {
              final tasks = taskProvider.tasks;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskCard(
                    taskId: task["_id"],
                    taskNumber: index + 1,
                    taskTitle: task['title'],
                    taskDescription: task['description'],
                    isCompleted: task['completed'],
                    onDelete: () {
                      taskProvider.deleteTask(task["_id"]);
                      setState(() {});
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
