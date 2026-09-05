import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/features/task/viewmodel/task_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../category/model/category_model.dart';
import '../../category/view/widgets/choose_category_sheet.dart';
import '../model/task_model.dart';
import '../viewmodel/task_cubit.dart';
import 'widgets/delete_task_dialog.dart';
import 'widgets/edit_title_sheet.dart';
import 'widgets/priority_picker_sheet.dart';
import 'widgets/task_detail_row.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  void _onEditTitleTap(TaskModel task) async {
    final result = await showModalBottomSheet<EditTitleResult>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => EditTitleSheet(
        initialTitle: widget.task.title,
        initialDescription: widget.task.description,
      ),
    );
    if (result != null && mounted) {
      context.read<TaskCubit>().editTitle(
        task.id,
        result.title,
        result.description,
      );
    }
  }

  void _onTimeTap() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  void _onCategoryTap(TaskModel task) async {
    final result = await showModalBottomSheet<CategoryModel>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ChooseCategorySheet(),
    );

    if (result != null && mounted) {
      context.read<TaskCubit>().changeCategory(
        task.id,
        result.name,
        result.color,
      );
    }
  }

  void _onPriorityTap(TaskModel task) async {
    final result = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) =>
          PriorityPickerSheet(initialPriority: widget.task.priority),
    );

    if (result != null && mounted) {
      context.read<TaskCubit>().changePriority(task.id, result);
    }
  }

  void _onDeleteTap(TaskModel task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteTaskDialog(taskTitle: widget.task.title),
    );
    if (confirmed == true && mounted) {
      context.read<TaskCubit>().deleteTask(task.id);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        TaskModel task = widget.task;
        if (state is TaskLoaded) {
          for (final t in state.tasks) {
            if (t.id == widget.task.id) task = t;
          }
          for (final t in state.completedTasks) {
            if (t.id == widget.task.id) task = t;
          }
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle_outlined,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.task.title,
                          style: AppTextStyles.headlineBold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _onEditTitleTap(task),
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Text(
                      widget.task.description,
                      style: AppTextStyles.bodySecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppColors.border),
                  TaskDetailRow(
                    icon: Icons.access_time,
                    label: 'Task Time:',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.task.time,
                        style: AppTextStyles.mutedLabel,
                      ),
                    ),
                    onTap: _onTimeTap,
                  ),
                  const Divider(color: AppColors.border),
                  TaskDetailRow(
                    icon: Icons.local_offer_outlined,
                    label: 'Task Category:',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: widget.task.labelColor,
                            child: const Icon(
                              Icons.school,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.task.label,
                            style: AppTextStyles.mutedLabel,
                          ),
                        ],
                      ),
                    ),
                    onTap: () => _onCategoryTap(task),
                  ),
                  const Divider(color: AppColors.border),
                  TaskDetailRow(
                    icon: Icons.flag_outlined,
                    label: 'Task Priority:',
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Default', style: AppTextStyles.mutedLabel),
                    ),
                    onTap: () => _onPriorityTap(task),
                  ),
                  const Divider(color: AppColors.border),
                  TaskDetailRow(
                    icon: Icons.delete_outline,
                    label: 'Delete Task',
                    iconColor: Colors.red,
                    labelColor: Colors.red,
                    trailing: const SizedBox(),
                    onTap: () => _onDeleteTap(task),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
