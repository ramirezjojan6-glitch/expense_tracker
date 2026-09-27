import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SummaryCardsRow extends StatefulWidget {
  const SummaryCardsRow({super.key});

  @override
  State<SummaryCardsRow> createState() => _SummaryCardsRowState();
}

class _SummaryCardsRowState extends State<SummaryCardsRow> {
  int _selectedIndex = 0;

  static const _items = [
    ('Balance', '₱8,450', 'AVAILABLE BALANCE', AppColors.darkTeal),
    ('Income', '₱15,000', 'TOTAL INCOME THIS MONTH', AppColors.cyan),
    ('Expenses', '₱6,550', 'TOTAL EXPENSES THIS MONTH', AppColors.pink),
    ('Remaining', '₱3,450', 'REMAINING THIS MONTH', AppColors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    final selected = _items[_selectedIndex];

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              for (var i = 0; i < _items.length; i++)
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: i == _selectedIndex
                            ? _items[i].$4
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              i == 0 ? const Radius.circular(16) : Radius.zero,
                          topRight: i == _items.length - 1
                              ? const Radius.circular(16)
                              : Radius.zero,
                        ),
                      ),
                      child: Text(
                        _items[i].$1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: i == _selectedIndex
                              ? Colors.white
                              : AppColors.darkTeal,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected.$4,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selected.$3,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 0.5,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                selected.$2,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}