import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SpendingOverviewCard extends StatelessWidget {
  const SpendingOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spending overview',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTeal,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: AppColors.cyan,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Food · 38%', style: TextStyle(fontSize: 12)),
                    Text('Transport · 18%', style: TextStyle(fontSize: 12)),
                    Text('School · 12%', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}