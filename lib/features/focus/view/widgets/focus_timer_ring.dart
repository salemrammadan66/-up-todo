import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class FocusTimerRing extends StatelessWidget {
  final double progress;
  final String timeText;

  const FocusTimerRing({
    super.key,
    required this.progress,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 10,
              color: AppColors.surface,
            ),
          ),
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              color: AppColors.primary,
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(timeText, style: AppTextStyles.headlineBold.copyWith(fontSize: 32)),
        ],
      ),
    );
  }
}