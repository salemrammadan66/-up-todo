import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text_field.dart';

class TaskSearchBar extends StatelessWidget {
  const TaskSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: '',
      hint: 'Search for your task...',
      showLabel: false,
      prefixIcon: Icons.search,
    );
  }
}
