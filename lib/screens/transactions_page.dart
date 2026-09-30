import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../state/app_state.dart';
import '../widgets/glass_card.dart';
import '../widgets/transaction_row.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _tabIndex = 0;

  static const _tabs = ['All', 'Expenses', 'Income'];

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _formatDate(DateTime d) =>
      '${_months[d.month - 1]} ${d.day}, ${d.year}';

  List<TransactionEntry> _filtered() {
    final sorted = appState.sortedTransactions;
    if (_tabIndex == 1) return sorted.where((t) => !t.isIncome).toList();
    if (_tabIndex == 2) return sorted.where((t) => t.isIncome).toList();
    return sorted;
  }

  Widget _buildTabButton(int index) {
    final selected = index == _tabIndex;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _tabIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.cyan
                : Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _tabs[index],
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.darkTeal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final list = _filtered();
        final children = <Widget>[];
        DateTime? lastDate;

        for (final t in list) {
          if (lastDate == null || lastDate.difference(t.date).inDays != 0) {
            children.add(
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  _formatDate(t.date),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ),
              ),
            );
          }
          children.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TransactionRow(transaction: t),
            ),
          );
          lastDate = t.date;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle('Transactions'),
              const SizedBox(height: 10),
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < _tabs.length; i++)
                          _buildTabButton(i),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: Column(
                        key: ValueKey(_tabIndex),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
