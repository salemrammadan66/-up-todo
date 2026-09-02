import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../features/task/view/widgets/add_task_sheet.dart';

class AddTaskFab extends StatelessWidget {
  const AddTaskFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.surface,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => const AddTaskSheet(),
        );
      },
      backgroundColor: AppColors.primary,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
