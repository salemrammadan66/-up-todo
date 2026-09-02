import 'package:flutter/material.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ChangeNameSheet extends StatefulWidget {
  final String currentName;

  const ChangeNameSheet({super.key, required this.currentName});

  @override
  State<ChangeNameSheet> createState() => _ChangeNameSheetState();
}

class _ChangeNameSheetState extends State<ChangeNameSheet> {
  late final _nameController = TextEditingController(text: widget.currentName);

  @override
  void dispose() {
    _nameController.dispose();
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
          Text('Change account name', style: AppTextStyles.headlineBold),
          const SizedBox(height: 16),
          CustomTextField(
            label: '',
            hint: 'Full name',
            showLabel: false,
            controller: _nameController,
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
                  onPressed: () => Navigator.pop(context, _nameController.text),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
