import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'features/onboarding/view/splash_screen.dart';

void main() {
  runApp(const UpTodoApp());
}

class UpTodoApp extends StatelessWidget {
  const UpTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
