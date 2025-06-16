import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';

class CallFilterModel {
  final String title;
  final IconData icon;
  final Color color;
  final CallType? type;

  CallFilterModel({
    required this.icon,
    required this.color,
    required this.title,
    this.type
  });
}
