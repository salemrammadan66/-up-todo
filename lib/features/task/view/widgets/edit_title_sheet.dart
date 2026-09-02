import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class EditTitleResult {
  final String title;
  final String description;

  const EditTitleResult({required this.title, required this.description});
}

class EditTitleSheet extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;

  const EditTitleSheet({
    super.key,
    required this.initialTitle,
    required this.initialDescription,
  });

  @override
  State<EditTitleSheet> createState() => _EditTitleSheetState();
}

class _EditTitleSheetState extends State<EditTitleSheet> {
  late final _titleController = TextEditingController(
    text: widget.initialTitle,
  );
  late final _descriptionController = TextEditingController(
    text: widget.initialDescription,
  );

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
          Text('Edit Task title', style: AppTextStyles.headlineBold),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            style: AppTextStyles.buttonText,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            style: AppTextStyles.bodySecondary,
            maxLines: 2,
            decoration: const InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                  text: 'Edit',
                  onPressed: () => Navigator.pop(
                    context,
                    EditTitleResult(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    ),
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
