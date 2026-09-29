import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../widgets/glass_card.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _Transaction {
  final DateTime date;
  final String description;
  final String category;
  final String amount;
  final Color color;
  final bool isIncome;

  const _Transaction({
    required this.date,
    required this.description,
    required this.category,
    required this.amount,
    required this.color,
    required this.isIncome,
  });
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _tabIndex = 0;

  static const _tabs = ['All', 'Expenses', 'Income'];

  static final _transactions = [
    _Transaction(
      date: DateTime(2026, 9, 27),
      description: 'Lunch',
      category: 'Food',
      amount: '-₱150',
      color: AppColors.pink,
      isIncome: false,
    ),
    _Transaction(
      date: DateTime(2026, 9, 26),
      description: 'Jeepney fare',
      category: 'Transport',
      amount: '-₱80',
      color: AppColors.pink,
      isIncome: false,
    ),
    _Transaction(
      date: DateTime(2026, 9, 25),
      description: 'School supplies',
      category: 'School',
      amount: '-₱350',
      color: AppColors.pink,
      isIncome: false,
    ),
    _Transaction(
      date: DateTime(2026, 9, 24),
      description: 'Allowance',
      category: 'Income',
      amount: '+₱2,000',
      color: AppColors.teal,
      isIncome: true,
    ),
    _Transaction(
      date: DateTime(2026, 9, 22),
      description: 'Groceries',
      category: 'Food',
      amount: '-₱420',
      color: AppColors.pink,
      isIncome: false,
    ),
    _Transaction(
      date: DateTime(2026, 9, 20),
      description: 'Internet load',
      category: 'Bills',
      amount: '-₱299',
      color: AppColors.pink,
      isIncome: false,
    ),
    _Transaction(
      date: DateTime(2026, 9, 18),
      description: 'Part-time job',
      category: 'Income',
      amount: '+₱1,500',
      color: AppColors.teal,
      isIncome: true,
    ),
    _Transaction(
      date: DateTime(2026, 9, 16),
      description: 'Book purchase',
      category: 'School',
      amount: '-₱450',
      color: AppColors.pink,
      isIncome: false,
    ),
  ];

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatDate(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

  List<_Transaction> get _filtered {
    final sorted = [..._transactions]..sort((a, b) => b.date.compareTo(a.date));
    if (_tabIndex == 1) {
      return sorted.where((t) => !t.isIncome).toList();
    }
    if (_tabIndex == 2) {
      return sorted.where((t) => t.isIncome).toList();
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.darkTeal,
                    ),
                  ),
                  Text(
                    t.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Text(
                t.amount,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: t.color,
                ),
              ),
            ],
          ),
        ),
      );
      lastDate = t.date;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle('Transactions'),
          const SizedBox(height: 16),
          GlassCard(
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
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}