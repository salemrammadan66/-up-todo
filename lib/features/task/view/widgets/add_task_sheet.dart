import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../category/model/category_model.dart';
import '../../../category/view/widgets/choose_category_sheet.dart';
import '../../model/task_model.dart';
import '../../viewmodel/task_cubit.dart';
import 'date_time_picker_sheet.dart';
import 'priority_picker_sheet.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedPriority;
  CategoryModel? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onDateTimeTap() async {
    final result = await showModalBottomSheet<DateTimeResult>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DateTimePickerSheet(
        initialDate: _selectedDate,
        initialTime: _selectedTime,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedDate = result.date;
        _selectedTime = result.time;
      });
    }
  }

  void _onCategoryTap() async {
    final result = await showModalBottomSheet<CategoryModel>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ChooseCategorySheet(),
    );

    if (result != null) {
      setState(() => _selectedCategory = result);
    }
  }

  void _onPriorityTap() async {
    final result = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => PriorityPickerSheet(initialPriority: _selectedPriority),
    );

    if (result != null) {
      setState(() => _selectedPriority = result);
    }
  }

  void _onSendTap() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    String timeText = 'No due date';
    if (_selectedDate != null && _selectedTime != null) {
      final hour = _selectedTime!.hour.toString().padLeft(2, '0');
      final minute = _selectedTime!.minute.toString().padLeft(2, '0');
      timeText =
          '${_selectedDate!.day}/${_selectedDate!.month} At $hour:$minute';
    }

    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      time: timeText,
      dueDate: _selectedDate != null
          ? DateTime(
              _selectedDate!.year,
              _selectedDate!.month,
              _selectedDate!.day,
            )
          : DateTime.now(),
      description: _descriptionController.text.trim(),
      label: _selectedCategory?.name ?? 'General',
      labelColor: _selectedCategory?.color ?? AppColors.primary,
      priority: _selectedPriority ?? 1,
    );

    context.read<TaskCubit>().addTask(newTask);
    Navigator.pop(context);
  }

  Widget _buildChip({required IconData icon, String? label, Color? color}) {
    final bool isSelected = label != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? (color ?? AppColors.primary) : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? Colors.white : AppColors.textMuted,
          ),
          if (isSelected) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.mutedLabel.copyWith(color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add Task', style: AppTextStyles.headlineBold),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            style: AppTextStyles.buttonText,
            decoration: const InputDecoration(
              hintText: 'Task title',
              hintStyle: AppTextStyles.bodySecondary,
              border: InputBorder.none,
            ),
          ),
          const Divider(color: AppColors.border),
          TextField(
            controller: _descriptionController,
            style: AppTextStyles.bodySecondary,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Description',
              hintStyle: AppTextStyles.bodySecondary,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _onDateTimeTap,
                        child: _buildChip(
                          icon: Icons.access_time,
                          label: _selectedDate != null && _selectedTime != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month} ${_selectedTime!.format(context)}'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _onCategoryTap,
                        child: _buildChip(
                          icon:
                              _selectedCategory?.icon ??
                              Icons.local_offer_outlined,
                          label: _selectedCategory?.name,
                          color: _selectedCategory?.color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _onPriorityTap,
                        child: _buildChip(
                          icon: Icons.flag_outlined,
                          label: _selectedPriority != null
                              ? 'Priority $_selectedPriority'
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _onSendTap,
                icon: const Icon(Icons.send, color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
