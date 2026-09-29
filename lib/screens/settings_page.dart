import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../widgets/glass_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _rows = [
    ('Currency', 'Philippine peso', Icons.attach_money),
    ('Monthly budget', '₱10,000', Icons.pie_chart_outline),
    ('Appearance', 'Light mode', Icons.dark_mode_outlined),
    ('Data & backup', 'Save to cloud', Icons.cloud_outlined),
    ('About', 'Version 1.0', Icons.info_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle('Settings'),
          const SizedBox(height: 16),
          GlassCard(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jojan',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Text(
                      'Student',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.teal,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < _rows.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: i == _rows.length - 1
                          ? null
                          : Border(
                              bottom: BorderSide(
                                color: Colors.black.withOpacity(0.06),
                              ),
                            ),
                    ),
                    child: Row(
                      children: [
                        Icon(_rows[i].$3, size: 18, color: AppColors.teal),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _rows[i].$1,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.darkTeal,
                            ),
                          ),
                        ),
                        Text(
                          _rows[i].$2,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}