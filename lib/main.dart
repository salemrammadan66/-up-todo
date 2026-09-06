import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/features/category/viewmodel/category_cubit.dart';
import 'package:up_todo/features/focus/viewmodel/focus_cubit.dart';
import 'package:up_todo/features/profile/viewmodel/profile_cubit.dart';
import 'package:up_todo/features/task/viewmodel/task_cubit.dart';
import 'core/constants/app_colors.dart';
import 'features/auth/viewmodel/auth_cubit.dart';
import 'features/onboarding/view/splash_screen.dart';

void main() {
  runApp(const UpTodoApp());
}

class UpTodoApp extends StatelessWidget {
  const UpTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => TaskCubit()..loadTasks()),
        BlocProvider(create: (context) => CategoryCubit()..loadCategories()),
        BlocProvider(create: (context) => ProfileCubit()..loadProfile()),
        BlocProvider(create: (context) => FocusCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
