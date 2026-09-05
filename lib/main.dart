import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:up_todo/features/task/viewmodel/task_cubit.dart';
import 'core/constants/app_colors.dart';
import 'features/onboarding/view/splash_screen.dart';

void main() {
  runApp(const UpTodoApp());
}

class UpTodoApp extends StatelessWidget {
  const UpTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..loadTasks(),
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
