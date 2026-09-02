import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class PriorityPickerSheet extends StatefulWidget {
  final int? initialPriority;

  const PriorityPickerSheet({super.key, this.initialPriority});

  @override
  State<PriorityPickerSheet> createState() => _PriorityPickerSheetState();
}

class _PriorityPickerSheetState extends State<PriorityPickerSheet> {
  int? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Task Priority', style: AppTextStyles.headlineBold),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(10, (index) {
              final int number = index + 1;
              final bool isSelected = number == _selectedPriority;
              return GestureDetector(
                onTap: () => setState(() => _selectedPriority = number),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: isSelected ? Colors.white : AppColors.textMuted,
                        size: 18,
                      ),
                      Text(
                        '$number',
                        style: AppTextStyles.mutedLabel.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  isOutlined: true,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Save',
                  onPressed: _selectedPriority != null
                      ? () => Navigator.pop(context, _selectedPriority)
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
