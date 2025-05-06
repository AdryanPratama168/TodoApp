import 'package:get/get.dart';
import 'package:login_sqflite_getx/models/task.dart';
import 'package:login_sqflite_getx/services/database_helper.dart';

class TodoController extends GetxController {
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  fetchTasks() async {
    tasks.value = await DatabaseHelper.instance.fetchTasks();
  }

  addTask(Task task) async {
    await DatabaseHelper.instance.insert(task.toMap());
    fetchTasks();
  }

  updateTask(Task task) async {
    await DatabaseHelper.instance.update(task.toMap());
    fetchTasks();
  }

  deleteTask(int id) async {
    await DatabaseHelper.instance.delete(id);
    fetchTasks();
  }
}
