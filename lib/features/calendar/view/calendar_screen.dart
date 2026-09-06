import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/add_task_fab.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../focus/view/focus_screen.dart';
import '../../home/view/home_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../task/viewmodel/task_cubit.dart';
import '../../task/viewmodel/task_state.dart';
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
  static const _monthNames = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];

  late DateTime _selectedDate;
  late List<DateTime> _weekDates;
  bool _isTodaySelected = true;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _selectedDate = DateTime(today.year, today.month, today.day);
    _weekDates = _buildWeekDates(_selectedDate);
  }

  List<DateTime> _buildWeekDates(DateTime date) {
    // Dart weekday: Monday = 1 ... Sunday = 7. We want the week to start on Sunday.
    final daysFromSunday = date.weekday % 7;
    final sunday = date.subtract(Duration(days: daysFromSunday));
    return List.generate(7, (index) => sunday.add(Duration(days: index)));
  }

  void _onDaySelected(int day) {
    final match = _weekDates.firstWhere((d) => d.day == day);
    setState(() => _selectedDate = match);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
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
              monthLabel: _monthNames[_selectedDate.month - 1],
              days: _weekDates.map((d) => d.day).toList(),
              selectedDay: _selectedDate.day,
              onDaySelected: _onDaySelected,
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
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is! TaskLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final sourceList = _isTodaySelected
                      ? state.tasks
                      : state.completedTasks;

                  final tasks = sourceList
                      .where(
                        (task) =>
                            task.dueDate != null &&
                            _isSameDay(task.dueDate!, _selectedDate),
                      )
                      .toList();

                  if (tasks.isEmpty) {
                    return Center(
                      child: Text(
                        'No tasks for this day',
                        style: AppTextStyles.bodySecondary,
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      for (final task in tasks)
                        TaskCard(
                          task: task,
                          onToggleComplete: () =>
                              context.read<TaskCubit>().toggleComplete(task.id),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailScreen(task: task),
                            ),
                          ),
                        ),
                    ],
                  );
                },
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
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FocusScreen()),
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
