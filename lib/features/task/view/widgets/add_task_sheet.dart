import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../category/model/category_model.dart';
import '../../../category/view/widgets/choose_category_sheet.dart';
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
            children: [
              IconButton(
                onPressed: _onDateTimeTap,
                icon: const Icon(Icons.access_time, color: AppColors.textMuted),
              ),
              IconButton(
                onPressed: _onCategoryTap,
                icon: const Icon(
                  Icons.local_offer_outlined,
                  color: AppColors.textMuted,
                ),
              ),
              IconButton(
                onPressed: _onPriorityTap,
                icon: const Icon(
                  Icons.flag_outlined,
                  color: AppColors.textMuted,
                ),
              ),
              const Spacer(),
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
