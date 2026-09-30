import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';

class TransactionRow extends StatelessWidget {
  final TransactionEntry transaction;

  const TransactionRow({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.description,
              style: const TextStyle(fontSize: 13, color: AppColors.darkTeal),
            ),
            Text(
              transaction.category,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ],
        ),
        Text(
          '${transaction.isIncome ? '+' : '-'}₱${transaction.amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: transaction.isIncome ? AppColors.teal : AppColors.pink,
          ),
        ),
      ],
    );
  }
}
