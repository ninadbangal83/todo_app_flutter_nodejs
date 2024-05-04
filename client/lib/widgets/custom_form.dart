import 'package:flutter/material.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_text_field.dart';

class CustomForm extends StatelessWidget {
  final TextEditingController taskTitle;
  final TextEditingController taskDescription;
  final bool taskStatus;
  final Function(bool?) onTaskStatusChanged;
  final String buttonText;
  final void Function() onSubmit;

  const CustomForm({
    super.key,
    required this.taskTitle,
    required this.taskStatus,
    required this.onTaskStatusChanged,
    required this.buttonText,
    required this.onSubmit,
    required this.taskDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: CustomTextField(
            label: "Title",
            enabled: true,
            value: taskTitle,
            focusedBorderColor: Colors.blue,
            enabledBorderColor: Colors.blue,
            disabledBorderColor: Colors.blue,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: CustomTextField(
            maxLines: 4,
            label: "Description",
            enabled: true,
            value: taskDescription,
            focusedBorderColor: Colors.blue,
            enabledBorderColor: Colors.blue,
            disabledBorderColor: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Checkbox(
              value: taskStatus,
              onChanged: onTaskStatusChanged,
            ),
            const Text('Completed'),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          child: CustomButtons(
            btnName: buttonText,
            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            bgColor: Colors.blue,
            handleClick: onSubmit,
          ),
        ),
      ],
    );
  }
}