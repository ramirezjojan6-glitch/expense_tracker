import 'package:flutter/material.dart';
import 'app_colors.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Fredoka',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTeal,
      ),
    );
  }
}