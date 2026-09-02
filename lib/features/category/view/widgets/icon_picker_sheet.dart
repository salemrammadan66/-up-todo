import 'package:flutter/material.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import 'icon_grid_item.dart';

class IconPickerSheet extends StatefulWidget {
  final IconData? initialIcon;

  const IconPickerSheet({super.key, this.initialIcon});

  @override
  State<IconPickerSheet> createState() => _IconPickerSheetState();
}

class _IconPickerSheetState extends State<IconPickerSheet> {
  IconData? _selectedIcon;

  static const List<IconData> _availableIcons = [
    Icons.shopping_cart,
    Icons.work,
    Icons.fitness_center,
    Icons.brush,
    Icons.school,
    Icons.campaign,
    Icons.music_note,
    Icons.favorite,
    Icons.movie,
    Icons.home,
    Icons.pets,
    Icons.book,
  ];

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.initialIcon;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Choose Icon', style: AppTextStyles.headlineBold),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final icon in _availableIcons)
                IconGridItem(
                  icon: icon,
                  isSelected: icon == _selectedIcon,
                  onTap: () => setState(() => _selectedIcon = icon),
                ),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Save',
            onPressed: _selectedIcon != null
                ? () => Navigator.pop(context, _selectedIcon)
                : null,
          ),
        ],
      ),
    );
  }
}
