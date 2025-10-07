import 'package:flutter/material.dart';

class Service {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int estMinutes;
  final int fee;

  const Service({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.estMinutes,
    required this.fee,
  });
}
