import 'package:flutter/material.dart';
import '../utils/create_edit_tasks_handler.dart';
import '../widgets/custom_form.dart';

class CreateEditTaskScreen extends StatefulWidget {
  final String title;
  final String btnText;
  final String? taskId;
  final String? taskTitle;
  final String? taskDescription;
  final bool? taskStatus;

  const CreateEditTaskScreen(
      {super.key,
      required this.title,
      required this.btnText,
      this.taskId,
      this.taskTitle,
      this.taskDescription,
      this.taskStatus});

  @override
  State<CreateEditTaskScreen> createState() => _CreateEditTaskScreenState();
}

class _CreateEditTaskScreenState extends State<CreateEditTaskScreen> {
  final taskTitle = TextEditingController();

  final taskDescription = TextEditingController();

  bool taskStatus = false;

  @override
  void initState() {
    super.initState();
    // Assign values based on props or defaults
    taskTitle.text = widget.taskTitle ??
        ''; // If widget.taskTitle is null, assign an empty string
    taskDescription.text = widget.taskDescription ??
        ''; // If widget.taskDescription is null, assign an empty string
    taskStatus = widget.taskStatus ??
        false; // If widget.taskStatus is null, assign false
  }

  void handleTaskStatusChange(bool? value) {
    // Handle checkbox value change
    setState(() {
      taskStatus = value ?? false; // Update the state of the checkbox
    });
  }

  void handleSubmit(BuildContext currentContext) async {
    final task = {
      "title": taskTitle.text,
      "description": taskDescription.text,
      "completed": taskStatus
    };

    try {
      // Perform the asynchronous operation (API request)
      await createEditTaskHandler(currentContext, widget.btnText, task, widget.taskId);
    } catch (error) {
      // Handle any errors that occur during the asynchronous operation
      print('Error: $error');
      // Optionally, you can show an error message to the user
    }
  }


  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: MediaQuery.of(context).size.width > 600
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 600, vertical: 200),
                    child: CustomForm(
                      taskTitle: taskTitle,
                      taskDescription: taskDescription,
                      taskStatus: taskStatus,
                      onTaskStatusChanged: handleTaskStatusChange,
                      buttonText: widget.btnText,
                      onSubmit: () => handleSubmit(currentContext),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomForm(
                      taskTitle: taskTitle,
                      taskDescription: taskDescription,
                      taskStatus: taskStatus,
                      onTaskStatusChanged: handleTaskStatusChange,
                      buttonText: widget.btnText,
                      onSubmit: () => handleSubmit(currentContext),
                    ),
                  ),
          ),
        ));
  }
}
