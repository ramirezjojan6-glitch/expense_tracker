import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Lunch', '-₱150', AppColors.pink),
      ('Allowance', '+₱2,000', AppColors.teal),
      ('Groceries', '-₱420', AppColors.pink),
    ];

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
            'Recent transactions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTeal,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(i.$1, style: const TextStyle(fontSize: 13)),
                  Text(
                    i.$2,
                    style: TextStyle(fontSize: 13, color: i.$3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}