import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _tabIndex = 0;

  static const _tabs = ['All', 'Expenses', 'Income'];

  static const _transactions = [
    ('Lunch', 'Food', '-₱150', AppColors.pink, false),
    ('Jeepney fare', 'Transport', '-₱80', AppColors.pink, false),
    ('School supplies', 'School', '-₱350', AppColors.pink, false),
    ('Allowance', 'Income', '+₱2,000', AppColors.teal, true),
    ('Groceries', 'Food', '-₱420', AppColors.pink, false),
    ('Internet load', 'Bills', '-₱299', AppColors.pink, false),
    ('Part-time job', 'Income', '+₱1,500', AppColors.teal, true),
    ('Book purchase', 'School', '-₱450', AppColors.pink, false),
  ];

  List<(String, String, String, Color, bool)> get _filtered {
    if (_tabIndex == 1) {
      return _transactions.where((t) => !t.$5).toList();
    }
    if (_tabIndex == 2) {
      return _transactions.where((t) => t.$5).toList();
    }
    return _transactions;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (var i = 0; i < _tabs.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _tabIndex = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: i == _tabIndex
                              ? AppColors.cyan
                              : Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _tabs[i],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: i == _tabIndex
                                ? Colors.white
                                : AppColors.darkTeal,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            for (final t in _filtered)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.$1,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.darkTeal,
                          ),
                        ),
                        Text(
                          t.$2,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      t.$3,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: t.$4,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}