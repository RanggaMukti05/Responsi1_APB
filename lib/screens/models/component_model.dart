import 'package:flutter/material.dart';

class ComponentItem {
  final String title;
  final IconData icon;
  final Color color;
  final Widget page; 

  ComponentItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });
}