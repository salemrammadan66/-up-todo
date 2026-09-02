import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<double> hours;
  final List<String> labels;
  final List<String> displayLabels;
  final int highlightedIndex;

  const WeeklyBarChart({
    super.key,
    required this.hours,
    required this.labels,
    required this.displayLabels,
    required this.highlightedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 6,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 4,
              getTooltipColor: (_) => Colors.transparent,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  displayLabels[groupIndex],
                  AppTextStyles.mutedLabel,
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final int index = value.toInt();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[index],
                      style: AppTextStyles.mutedLabel.copyWith(
                        color: labels[index] == 'SAT'
                            ? Colors.red
                            : AppColors.textMuted,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(hours.length, (index) {
            final bool isHighlighted = index == highlightedIndex;
            return BarChartGroupData(
              x: index,
              showingTooltipIndicators: [0],
              barRods: [
                BarChartRodData(
                  toY: hours[index],
                  color: isHighlighted ? AppColors.primary : AppColors.surface,
                  width: 20,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
