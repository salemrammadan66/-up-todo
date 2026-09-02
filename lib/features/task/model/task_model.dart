import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final String time;
  final String description;
  final String label;
  final Color labelColor;
  final int priority;
  final bool isCompleted;

  const TaskModel({
    required this.title,
    required this.time,
    required this.description,
    required this.label,
    required this.labelColor,
    required this.priority,
    this.isCompleted = false,
  });
}
