import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class TaskDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? labelColor;
  final Widget trailing;
  final VoidCallback onTap;
  final Color? iconColor;

  const TaskDetailRow({
    super.key,
    required this.icon,
    required this.label,
    this.labelColor,
    required this.trailing,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 18, color: iconColor ?? AppColors.textMuted),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.bodySecondary.copyWith(color: labelColor),
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}
