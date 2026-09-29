import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_card.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Lunch', 'Food', '-₱150', AppColors.pink),
      ('Allowance', 'Income', '+₱2,000', AppColors.teal),
      ('Groceries', 'Food', '-₱420', AppColors.pink),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent transactions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        for (final i in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              borderRadius: 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        i.$1,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.darkTeal,
                        ),
                      ),
                      Text(
                        i.$2,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    i.$3,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: i.$4,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}