import 'package:flutter/material.dart';
import 'package:up_todo/features/home/view/home_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'register_screen.dart';
import 'widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 40),
              Text('Login', style: AppTextStyles.headlineBold),
              const SizedBox(height: 55),
              CustomTextField(
                label: 'Username',
                hint: 'Enter your Username',
                controller: _usernameController,
              ),
              const SizedBox(height: 25),
              CustomTextField(
                label: 'Password',
                hint: '••••••••••',
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 70),
              CustomButton(
                text: 'Login',
                onPressed: _isFormValid
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('or', style: AppTextStyles.bodySecondary),
                  ),
                  Expanded(child: Divider(color: AppColors.border)),
                ],
              ),
              const SizedBox(height: 30),
              SocialButton(
                text: 'Login with Google',
                imagePath: 'assets/images/google.png',
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              SocialButton(
                text: 'Login with Apple',
                imagePath: 'assets/images/apple.png',
                onPressed: () {},
              ),
              const SizedBox(height: 40),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTextStyles.bodySecondary,
                      ),
                      Text(
                        'Register',
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
