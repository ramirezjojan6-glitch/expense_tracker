import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import 'home_page.dart';
import 'transactions_page.dart';
import 'placeholder_page.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _selectedIndex = 0;

  static const _labels = [
    'Dashboard',
    'Transactions',
    'Add expense',
    'Budget',
    'Savings',
    'Settings',
  ];

  static const _icons = [
    Icons.dashboard_outlined,
    Icons.receipt_long_outlined,
    Icons.add_circle_outline,
    Icons.pie_chart_outline,
    Icons.savings_outlined,
    Icons.settings_outlined,
  ];

  final _pages = const [
    HomePage(),
    TransactionsPage(),
    PlaceholderPage(label: 'Add expense'),
    PlaceholderPage(label: 'Budget'),
    PlaceholderPage(label: 'Savings'),
    PlaceholderPage(label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.softCyan,
              AppColors.softPink,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  _labels[_selectedIndex],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: GlassCard(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            borderRadius: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < _icons.length; i++)
                  GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: Icon(
                      _icons[i],
                      size: 22,
                      color: i == _selectedIndex
                          ? AppColors.cyan
                          : AppColors.darkTeal.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}