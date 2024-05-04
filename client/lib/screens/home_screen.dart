import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app_flutter_nodejs/screens/create_edit_task_screen.dart';
import 'package:todo_app_flutter_nodejs/widgets/custom_appbar.dart';
import 'package:todo_app_flutter_nodejs/widgets/tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showWelcomeMessage = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showWelcomeMessage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Tasks"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // if (_showWelcomeMessage) _buildWelcomeMessage(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: MediaQuery.of(context).size.width > 600
                ? const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 300, vertical: 30),
                    child: Task(),
                  )
                : const Task(),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateEditTaskScreen(
                      title: "Create Task", btnText: "Create")),
            );
          },
          backgroundColor: Colors.blue,
          shape: const CircleBorder(), // Set button color to blue
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      color: Colors.green, // Customize the background color
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(top: 8, bottom: 8), // Customize the padding
      child: const Center(
        child: Text(
          'Welcome, User!',
          style: TextStyle(
            color: Colors.white, // Customize the text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
