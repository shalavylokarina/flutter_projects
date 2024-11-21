import 'package:lab2/object/task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchTasks();

  Future<void> addTask(String taskName);

  Future<void> deleteTask(String id);
}