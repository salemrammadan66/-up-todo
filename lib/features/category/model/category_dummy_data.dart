import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'category_model.dart';

class CategoryDummyData {
  CategoryDummyData._();

  static const List<CategoryModel> categories = [
    CategoryModel(
      name: 'Grocery',
      icon: Icons.shopping_cart,
      color: AppColors.groceryColor,
    ),
    CategoryModel(name: 'Work', icon: Icons.work, color: AppColors.workColor),
    CategoryModel(
      name: 'Sport',
      icon: Icons.fitness_center,
      color: AppColors.sportColor,
    ),
    CategoryModel(
      name: 'Design',
      icon: Icons.brush,
      color: AppColors.designColor,
    ),
    CategoryModel(
      name: 'University',
      icon: Icons.school,
      color: AppColors.universityColor,
    ),
    CategoryModel(
      name: 'Social',
      icon: Icons.campaign,
      color: AppColors.socialColor,
    ),
    CategoryModel(
      name: 'Music',
      icon: Icons.music_note,
      color: AppColors.musicColor,
    ),
    CategoryModel(
      name: 'Health',
      icon: Icons.favorite,
      color: AppColors.healthColor,
    ),
    CategoryModel(
      name: 'Movie',
      icon: Icons.movie,
      color: AppColors.movieColor,
    ),
    CategoryModel(name: 'Home', icon: Icons.home, color: AppColors.homeColor),
  ];
}
