import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SummaryCardsRow extends StatelessWidget {
  const SummaryCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      ('Balance', '₱8,450', AppColors.teal),
      ('Income', '₱15,000', AppColors.cyan),
      ('Expenses', '₱6,550', AppColors.pink),
      ('Remaining', '₱3,450', AppColors.darkTeal),
    ];

    return Row(
      children: cards
          .map(
            (c) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.$1,
                      style: TextStyle(fontSize: 11, color: c.$3),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      c.$2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkTeal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}