import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/add_task_fab.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../task/model/task_dummy_data.dart';
import '../../task/view/task_detail_screen.dart';
import '../../task/view/widgets/task_card.dart';
import 'widgets/calendar_tab_selector.dart';
import 'widgets/week_calendar_strip.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedDay = 9;
  bool _isTodaySelected = true;

  @override
  Widget build(BuildContext context) {
    final tasks = _isTodaySelected
        ? TaskDummyData.tasks
        : TaskDummyData.completedTasks;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Calendar', style: AppTextStyles.headlineBold),
            ),
            WeekCalendarStrip(
              monthLabel: 'FEBRUARY',
              days: const [6, 7, 8, 9, 10, 11, 12],
              selectedDay: _selectedDay,
              onDaySelected: (day) => setState(() => _selectedDay = day),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CalendarTabSelector(
                isTodaySelected: _isTodaySelected,
                onChanged: (value) => setState(() => _isTodaySelected = value),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  for (final task in tasks)
                    TaskCard(
                      task: task,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TaskDetailScreen(task: task),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const AddTaskFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
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
