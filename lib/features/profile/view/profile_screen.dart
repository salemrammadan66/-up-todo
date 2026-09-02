import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/add_task_fab.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../calendar/view/calendar_screen.dart';
import '../../focus/view/focus_screen.dart';
import '../../home/view/home_screen.dart';
import '../../onboarding/view/welcome_screen.dart';
import 'widgets/change_image_sheet.dart';
import 'widgets/change_name_sheet.dart';
import 'widgets/change_password_sheet.dart';
import 'widgets/logout_dialog.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/profile_stat_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _onChangeNameTap(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ChangeNameSheet(currentName: 'Salem Ramadan'),
    );
  }

  void _onChangePasswordTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ChangePasswordSheet(),
    );
  }

  void _onChangeImageTap(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ChangeImageSheet(),
    );
  }

  void _onLogoutTap(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const LogoutDialog(),
    );
    if (confirmed == true && context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        (route) => false,
      );
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
              Center(child: Text('Profile', style: AppTextStyles.headlineBold)),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () => _onChangeImageTap(context),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.surface,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text('Salem Ramadan', style: AppTextStyles.buttonText),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  ProfileStatCard(label: '10 Task left'),
                  SizedBox(width: 12),
                  ProfileStatCard(label: '5 Task done'),
                ],
              ),
              const SizedBox(height: 24),
              Text('Settings', style: AppTextStyles.mutedLabel),
              ProfileMenuItem(
                icon: Icons.settings_outlined,
                label: 'App Settings',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              Text('Account', style: AppTextStyles.mutedLabel),
              ProfileMenuItem(
                icon: Icons.person_outline,
                label: 'Change account name',
                onTap: () => _onChangeNameTap(context),
              ),
              ProfileMenuItem(
                icon: Icons.lock_outline,
                label: 'Change account password',
                onTap: () => _onChangePasswordTap(context),
              ),
              ProfileMenuItem(
                icon: Icons.image_outlined,
                label: 'Change account Image',
                onTap: () => _onChangeImageTap(context),
              ),
              const SizedBox(height: 16),
              Text('Uptodo', style: AppTextStyles.mutedLabel),
              ProfileMenuItem(
                icon: Icons.info_outline,
                label: 'About US',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.help_outline,
                label: 'FAQ',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.feedback_outlined,
                label: 'Help & Feedback',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.support_agent_outlined,
                label: 'Support US',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.logout,
                label: 'Log out',
                color: Colors.red,
                onTap: () => _onLogoutTap(context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const AddTaskFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 3) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CalendarScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FocusScreen()),
            );
          }
        },
      ),
    );
  }
}
