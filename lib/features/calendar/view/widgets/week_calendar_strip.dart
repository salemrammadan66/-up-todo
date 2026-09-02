import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class WeekCalendarStrip extends StatelessWidget {
  final String monthLabel;
  final List<int> days;
  final int selectedDay;
  final ValueChanged<int> onDaySelected;

  const WeekCalendarStrip({
    super.key,
    required this.monthLabel,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  static const _weekdayLabels = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chevron_left, color: AppColors.textMuted),
            const SizedBox(width: 8),
            Text(monthLabel, style: AppTextStyles.buttonText),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(days.length, (index) {
            final bool isSelected = days[index] == selectedDay;
            return GestureDetector(
              onTap: () => onDaySelected(days[index]),
              child: Container(
                width: 40,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      _weekdayLabels[index],
                      style: AppTextStyles.mutedLabel.copyWith(
                        color: isSelected ? Colors.white : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${days[index]}',
                      style: AppTextStyles.buttonText.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
