import 'package:flutter/material.dart';

class TaskModel {
  final int id;
  final String title;
  final String time;
  final DateTime? dueDate;
  final String description;
  final String label;
  final Color labelColor;
  final int priority;
  final bool isCompleted;

  const TaskModel({
    required this.id,
    required this.title,
    required this.time,
    this.dueDate,
    required this.description,
    required this.label,
    required this.labelColor,
    required this.priority,
    this.isCompleted = false,
  });

  TaskModel copyWith({
    String? title,
    String? time,
    DateTime? dueDate,
    String? description,
    String? label,
    Color? labelColor,
    int? priority,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      time: time ?? this.time,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      label: label ?? this.label,
      labelColor: labelColor ?? this.labelColor,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}