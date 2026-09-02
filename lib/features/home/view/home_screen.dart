import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/add_task_fab.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../calendar/view/calendar_screen.dart';
import '../../focus/view/focus_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../task/model/task_dummy_data.dart';
import '../../task/view/task_detail_screen.dart';
import 'widgets/completed_section_header.dart';
import 'widgets/dropdown_filter.dart';
import '../../task/view/widgets/task_card.dart';
import 'widgets/task_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isCompletedExpanded = true;
  String _selectedFilter = 'Today';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, color: AppColors.textPrimary),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Index', style: AppTextStyles.headlineBold),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.surface,
                    backgroundImage: const AssetImage(
                      'assets/images/profile.jpg',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TaskDummyData.tasks.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/empty_home.png',
                              height: 200,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'What do you want to do today?',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.headlineBold,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap + to add your tasks',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySecondary,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        const TaskSearchBar(),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownFilter(
                            selected: _selectedFilter,
                            onChanged: (value) =>
                                setState(() => _selectedFilter = value!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (final task in TaskDummyData.tasks)
                          TaskCard(
                            task: task,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TaskDetailScreen(task: task),
                              ),
                            ),
                          ),
                        if (TaskDummyData.completedTasks.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          CompletedSectionHeader(
                            count: TaskDummyData.completedTasks.length,
                            isExpanded: _isCompletedExpanded,
                            onTap: () => setState(
                              () =>
                                  _isCompletedExpanded = !_isCompletedExpanded,
                            ),
                          ),
                          if (_isCompletedExpanded)
                            for (final task in TaskDummyData.completedTasks)
                              TaskCard(
                                task: task,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        TaskDetailScreen(task: task),
                                  ),
                                ),
                              ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: const AddTaskFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CalendarScreen()),
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
