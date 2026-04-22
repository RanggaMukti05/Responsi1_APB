
import 'package:flutter/material.dart';

enum NotificationType { applySuccess, completeProfile, interviewCalls }

class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final NotificationType type;
  final bool isUnread; 

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
    this.isUnread = false,
  });
}