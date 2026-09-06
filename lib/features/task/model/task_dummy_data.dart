import '../../../core/constants/app_colors.dart';
import 'task_model.dart';

class TaskDummyData {
  TaskDummyData._();

  static final DateTime _today = DateTime.now();

  static final List<TaskModel> tasks = [
    TaskModel(
      id: 1,
      title: 'Do Math Homework',
      time: 'Today At 16:45',
      dueDate: _today,
      description: 'Do chapter 2 to 5 for next week',
      label: 'University',
      labelColor: AppColors.universityColor,
      priority: 1,
    ),
    TaskModel(
      id: 2,
      title: 'Tack out dogs',
      time: 'Today At 19:20',
      dueDate: _today,
      description: 'Walk the dogs around the block twice',
      label: 'Home',
      labelColor: AppColors.homeColor,
      priority: 2,
    ),
    TaskModel(
      id: 3,
      title: 'Business meeting with CEO',
      time: 'Tomorrow At 08:15',
      dueDate: _today.add(const Duration(days: 1)),
      description: 'Discuss Q3 roadmap and budget',
      label: 'Work',
      labelColor: AppColors.workColor,
      priority: 3,
    ),
  ];

  static final List<TaskModel> completedTasks = [
    TaskModel(
      id: 4,
      title: 'Buy Grocery',
      time: 'Today At 12:45',
      dueDate: _today,
      description: 'Milk, eggs, bread, and vegetables',
      label: 'Home',
      labelColor: AppColors.homeColor,
      priority: 2,
      isCompleted: true,
    ),
  ];
}