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
    PlaceholderPage(label: 'Transactions'),
    PlaceholderPage(label: 'Add expense'),
    PlaceholderPage(label: 'Budget'),
    PlaceholderPage(label: 'Savings'),
    PlaceholderPage(label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _Sidebar(
            icons: _icons,
            labels: _labels,
            selectedIndex: _selectedIndex,
            onSelect: (i) => setState(() => _selectedIndex = i),
          ),
          Expanded(
            child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Text(
                        _labels[_selectedIndex],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkTeal,
                        ),
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
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _Sidebar({
    required this.icons,
    required this.labels,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: AppColors.darkTeal,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          for (var i = 0; i < icons.length; i++)
            _SidebarItem(
              icon: icons[i],
              label: labels[i],
              selected: i == selectedIndex,
              onTap: () => onSelect(i),
            ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: selected ? AppColors.cyan : Colors.transparent,
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? AppColors.darkTeal : AppColors.lightPink,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                color: selected ? AppColors.darkTeal : AppColors.lightPink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}