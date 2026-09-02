import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ChangeImageSheet extends StatelessWidget {
  const ChangeImageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Change account Image', style: AppTextStyles.headlineBold),
          const Divider(color: AppColors.border, height: 24),
          _buildOption(context, 'Take picture'),
          _buildOption(context, 'Import from gallery'),
          _buildOption(context, 'Import from Google Drive'),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label) {
    return InkWell(
      onTap: () => Navigator.pop(context, label),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(label, style: AppTextStyles.bodySecondary),
      ),
    );
  }
}
