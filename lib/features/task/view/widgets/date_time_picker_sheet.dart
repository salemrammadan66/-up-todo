import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class DateTimeResult {
  final DateTime date;
  final TimeOfDay time;

  const DateTimeResult({required this.date, required this.time});
}

class DateTimePickerSheet extends StatefulWidget {
  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  const DateTimePickerSheet({super.key, this.initialDate, this.initialTime});

  @override
  State<DateTimePickerSheet> createState() => _DateTimePickerSheetState();
}

class _DateTimePickerSheetState extends State<DateTimePickerSheet> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) _selectedDate = widget.initialDate!;
    if (widget.initialTime != null) _selectedTime = widget.initialTime!;
  }

  Future<void> _pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (result != null) {
      setState(() => _selectedDate = result);
    }
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (result != null) {
      setState(() => _selectedTime = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date & Time', style: AppTextStyles.headlineBold),
          const SizedBox(height: 24),
          ListTile(
            contentPadding: EdgeInsets.zero,
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(
              Icons.calendar_today,
              color: AppColors.textMuted,
            ),
            title: Text(
              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: AppTextStyles.buttonText,
            ),
            onTap: _pickDate,
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            tileColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: const Icon(Icons.access_time, color: AppColors.textMuted),
            title: Text(
              _selectedTime.format(context),
              style: AppTextStyles.buttonText,
            ),
            onTap: _pickTime,
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
                  onPressed: () => Navigator.pop(
                    context,
                    DateTimeResult(date: _selectedDate, time: _selectedTime),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
