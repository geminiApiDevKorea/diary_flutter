import 'package:flutter/material.dart';

class PopupButtonParam {
  final String title;
  final bool isPrimary;
  final Function(BuildContext context) onTap;
  const PopupButtonParam({
    required this.title,
    required this.isPrimary,
    required this.onTap,
  });
}
