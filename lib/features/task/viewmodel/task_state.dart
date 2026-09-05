import '../model/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;
  final List<TaskModel> completedTasks;

  TaskLoaded({required this.tasks, required this.completedTasks});
}
