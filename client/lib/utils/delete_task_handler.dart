import '../providers/task_provider.dart';
import '../services/task_services/delete_task_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

deleteTaskHandler(currentContext, taskId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');

  try {
    if (accessToken != null) {
      final response = await deleteTask(taskId, accessToken);

      if (response['status'] == 'success') {
        if (!currentContext.mounted) return;
        // final taskProvider = Provider.of<TaskProvider>(currentContext, listen: false);
        // taskProvider.fetchTasks();
        return;
      } else {
        // Handle login failure
      }
    }
  } catch (error) {
    // Handle error
  }
}