import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/features/category/viewmodel/category_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../model/category_dummy_data.dart';
import '../../model/category_model.dart';
import '../../viewmodel/category_state.dart';
import '../create_category_screen.dart';
import 'category_grid_item.dart';

class ChooseCategorySheet extends StatefulWidget {
  const ChooseCategorySheet({super.key});

  @override
  State<ChooseCategorySheet> createState() => _ChooseCategorySheetState();
}

class _ChooseCategorySheetState extends State<ChooseCategorySheet> {
  CategoryModel? _selectedCategory;

  void _onCreateNewTap() async {
    final result = await Navigator.push<CategoryModel>(
      context,
      MaterialPageRoute(builder: (_) => const CreateCategoryScreen()),
    );

    if (result != null) {
      context.read<CategoryCubit>().addCategory(result);
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Choose Category', style: AppTextStyles.headlineBold),
          const SizedBox(height: 24),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              final categories = state is CategoryLoaded
                  ? state.categories
                  : <CategoryModel>[];

              return GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (final category in categories)
                    CategoryGridItem(
                      icon: category.icon,
                      color: category.color,
                      label: category.name,
                      onTap: () => setState(() => _selectedCategory = category),
                    ),
                  CategoryGridItem(
                    icon: Icons.add,
                    color: AppColors.createNewCategoryColor,
                    label: 'Create New',
                    onTap: _onCreateNewTap,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
