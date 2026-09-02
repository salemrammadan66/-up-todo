import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../model/app_usage_model.dart';

class AppUsageTile extends StatelessWidget {
  final AppUsageModel app;
  final VoidCallback onInfoTap;

  const AppUsageTile({super.key, required this.app, required this.onInfoTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(app.iconPath, width: 36, height: 36),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(app.name, style: AppTextStyles.buttonText),
                const SizedBox(height: 2),
                Text(app.usageText, style: AppTextStyles.mutedLabel),
              ],
            ),
          ),
          IconButton(
            onPressed: onInfoTap,
            icon: const Icon(
              Icons.info_outline,
              color: AppColors.textMuted,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
