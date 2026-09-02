import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DropdownFilter extends StatelessWidget {
  final String selected;
  final ValueChanged<String?> onChanged;

  const DropdownFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selected,
        onChanged: onChanged,
        dropdownColor: AppColors.surface,
        underline: const SizedBox(),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.textPrimary,
        ),
        style: AppTextStyles.buttonText,
        items: const [
          DropdownMenuItem(value: 'Today', child: Text('Today')),
          DropdownMenuItem(value: 'This Week', child: Text('This Week')),
          DropdownMenuItem(value: 'This Month', child: Text('This Month')),
        ],
      ),
    );
  }
}
