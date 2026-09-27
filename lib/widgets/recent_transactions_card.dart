import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_card.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Lunch', '-₱150', AppColors.pink),
      ('Allowance', '+₱2,000', AppColors.teal),
      ('Groceries', '-₱420', AppColors.pink),
    ];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent transactions',
            style: Theme.of(context).textTheme.titleMedium,
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