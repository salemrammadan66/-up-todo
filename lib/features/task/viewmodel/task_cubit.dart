import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/task_dummy_data.dart';
import '../model/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];

  void loadTasks() {
    tasks = List.from(TaskDummyData.tasks);
    completedTasks = List.from(TaskDummyData.completedTasks);
    emitLoaded();
  }

  void addTask(TaskModel task) {
    tasks.add(task);
    emitLoaded();
  }

  void deleteTask(int id) {
    tasks.removeWhere((task) => task.id == id);
    completedTasks.removeWhere((task) => task.id == id);
    emitLoaded();
  }

  void toggleComplete(int id) {
    // Check if the task is in the active list first
    TaskModel? foundTask;
    for (final task in tasks) {
      if (task.id == id) {
        foundTask = task;
        break;
      }
    }

    if (foundTask != null) {
      tasks.remove(foundTask);
      completedTasks.add(foundTask.copyWith(isCompleted: true));
    } else {
      // If not found there, it must be in the completed list
      TaskModel? completedTask;
      for (final task in completedTasks) {
        if (task.id == id) {
          completedTask = task;
          break;
        }
      }
      if (completedTask != null) {
        completedTasks.remove(completedTask);
        tasks.add(completedTask.copyWith(isCompleted: false));
      }
    }

    emitLoaded();
  }

  void editTitle(int id, String title, String description) {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == id) {
        tasks[i] = tasks[i].copyWith(title: title, description: description);
      }
    }
    for (int i = 0; i < completedTasks.length; i++) {
      if (completedTasks[i].id == id) {
        completedTasks[i] = completedTasks[i].copyWith(
          title: title,
          description: description,
        );
      }
    }
    emitLoaded();
  }

  void changePriority(int id, int priority) {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == id) {
        tasks[i] = tasks[i].copyWith(priority: priority);
      }
    }
    emitLoaded();
  }

  void changeCategory(int id, String label, Color labelColor) {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == id) {
        tasks[i] = tasks[i].copyWith(label: label, labelColor: labelColor);
      }
    }
    emitLoaded();
  }

  void emitLoaded() {
    emit(TaskLoaded(tasks: tasks, completedTasks: completedTasks));
  }
}