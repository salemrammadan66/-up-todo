import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../model/category_model.dart';
import 'widgets/icon_picker_sheet.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final _nameController = TextEditingController();
  IconData? _selectedIcon;
  Color? _selectedColor;

  final List<Color> _availableColors = const [
    AppColors.groceryColor,
    AppColors.workColor,
    AppColors.sportColor,
    AppColors.designColor,
    AppColors.universityColor,
    AppColors.socialColor,
    AppColors.musicColor,
    AppColors.healthColor,
  ];

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
      _selectedIcon != null &&
      _selectedColor != null;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onChooseIconTap() async {
    final result = await showModalBottomSheet<IconData>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => IconPickerSheet(initialIcon: _selectedIcon),
    );

    if (result != null) {
      setState(() => _selectedIcon = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create new category', style: AppTextStyles.headlineBold),
              const SizedBox(height: 24),
              Text('Category name:', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 8),
              CustomTextField(
                label: '',
                hint: 'Category name',
                showLabel: false,
                controller: _nameController,
              ),
              const SizedBox(height: 24),
              Text('Category icon:', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _onChooseIconTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _selectedIcon == null
                      ? Text(
                          'Choose icon from library',
                          style: AppTextStyles.bodySecondary,
                        )
                      : Icon(_selectedIcon, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 24),
              Text('Category color:', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: [
                  for (final color in _availableColors)
                    GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: _selectedColor == color
                              ? Border.all(
                                  color: AppColors.textPrimary,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: _selectedColor == color
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: AppColors.background,
                              )
                            : null,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40),
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
                      text: 'Create Category',
                      onPressed: _isFormValid
                          ? () => Navigator.pop(
                              context,
                              CategoryModel(
                                name: _nameController.text,
                                icon: _selectedIcon!,
                                color: _selectedColor!,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
