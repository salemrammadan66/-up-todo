import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'login_screen.dart';
import 'widgets/social_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid =
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              const SizedBox(height: 16),
              Text('Register', style: AppTextStyles.headlineBold),
              const SizedBox(height: 23),
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
              const SizedBox(height: 25),
              CustomTextField(
                label: 'Confirm Password',
                hint: '••••••••••',
                isPassword: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 40),
              CustomButton(text: 'Register', onPressed: _isFormValid ? () {} : null),
              const SizedBox(height: 18),
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
              const SizedBox(height: 24),
              SocialButton(
                text: 'Register with Google',
                imagePath: 'assets/images/google.png',
                onPressed: () {},
              ),
              const SizedBox(height: 17),
              SocialButton(
                text: 'Register with Apple',
                imagePath: 'assets/images/apple.png',
                onPressed: () {},
              ),
              const SizedBox(height: 40),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodySecondary,
                      ),
                      Text(
                        'Login',
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
