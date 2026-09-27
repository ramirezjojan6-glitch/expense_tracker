import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'home_page.dart';
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

  // Dashboard is real; the rest are placeholders
  final _pages = const [
    HomePage(),
    PlaceholderPage(label: 'Transactions'),
    PlaceholderPage(label: 'Add expense'),
    PlaceholderPage(label: 'Budget'),
    PlaceholderPage(label: 'Savings'),
    PlaceholderPage(label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_labels[_selectedIndex]),
      ),
      body: Row(
        children: [
          _Sidebar(
            labels: _labels,
            onSelect: (i) => setState(() => _selectedIndex = i),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            // No animation: IndexedStack just swaps visibility instantly.
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}

/// Plain sidebar: text labels only, no icons, no selected-state
/// styling. Tapping a row just calls onSelect — no visual feedback.
class _Sidebar extends StatelessWidget {
  final List<String> labels;
  final ValueChanged<int> onSelect;

  const _Sidebar({
    required this.labels,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      color: AppColors.darkTeal,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          for (var i = 0; i < labels.length; i++)
            _SidebarItem(
              label: labels[i],
              onTap: () => onSelect(i),
            ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.lightPink,
          ),
        ),
      ),
    );
  }
}