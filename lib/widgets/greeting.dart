import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Good morning, Jojan!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.darkTeal,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Here's your financial summary.",
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }
}