import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/add_task_fab.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../calendar/view/calendar_screen.dart';
import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../model/focus_dummy_data.dart';
import 'widgets/app_usage_tile.dart';
import 'widgets/focus_timer_ring.dart';
import 'widgets/overview_header.dart';
import 'widgets/weekly_bar_chart.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  static const int _totalSeconds = 30 * 60;

  bool _isRunning = false;
  int _elapsedSeconds = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleFocus() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() => _isRunning = false);
    } else {
      setState(() => _isRunning = true);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_elapsedSeconds < _totalSeconds) {
            _elapsedSeconds++;
          } else {
            _timer?.cancel();
            _isRunning = false;
          }
        });
      });
    }
  }

  String get _formattedTime {
    final minutes = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Focus Mode', style: AppTextStyles.buttonText),
              const SizedBox(height: 32),
              FocusTimerRing(
                progress: _elapsedSeconds / _totalSeconds,
                timeText: _formattedTime,
              ),
              const SizedBox(height: 24),
              Text(
                'While your focus mode is on, all of your notifications will be off',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: _isRunning ? 'Stop Focusing' : 'Start Focusing',
                width: 50,
                onPressed: _toggleFocus,
              ),
              const SizedBox(height: 32),
              Align(alignment: Alignment.centerLeft, child: OverviewHeader()),
              const SizedBox(height: 16),
              WeeklyBarChart(
                hours: FocusDummyData.weeklyHours,
                labels: FocusDummyData.weeklyLabels,
                displayLabels: FocusDummyData.weeklyDisplayLabels,
                highlightedIndex: 5,
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Applications', style: AppTextStyles.buttonText),
              ),
              const SizedBox(height: 12),
              for (final app in FocusDummyData.apps)
                AppUsageTile(app: app, onInfoTap: () {}),
            ],
          ),
        ),
      ),
      floatingActionButton: const AddTaskFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 2) return;
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
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
