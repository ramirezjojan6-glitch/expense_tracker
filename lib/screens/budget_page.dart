import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../widgets/glass_card.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  static const _limits = [
    ('Food', 2500.0, 3000.0, AppColors.cyan),
    ('Transport', 1200.0, 2000.0, AppColors.teal),
    ('School', 800.0, 1500.0, AppColors.pink),
    ('Bills', 500.0, 1000.0, AppColors.darkTeal),
  ];

  static const _goals = [
    ('New laptop', 5000.0, 15000.0, Icons.laptop_mac, AppColors.cyan),
    ('Emergency fund', 3650.0, 5000.0, Icons.health_and_safety_outlined, AppColors.teal),
    ('Baguio trip', 500.0, 4000.0, Icons.flight_takeoff, AppColors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle('Budget'),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Monthly budget',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Text(
                      '65.5%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const _ProgressBar(value: 0.655, color: AppColors.cyan, height: 10),
                const SizedBox(height: 8),
                const Text(
                  '₱6,550 of ₱10,000 spent · ₱3,450 left',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category limits',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                for (final l in _limits)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l.$1,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.darkTeal,
                              ),
                            ),
                            Text(
                              '₱${l.$2.toInt()} / ₱${l.$3.toInt()}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _ProgressBar(value: l.$2 / l.$3, color: l.$4),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Savings goals',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Text(
                      'Total saved ₱9,150',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                for (final g in _goals)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: g.$5.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(g.$4, size: 20, color: g.$5),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    g.$1,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.darkTeal,
                                    ),
                                  ),
                                  Text(
                                    '₱${g.$2.toInt()} / ₱${g.$3.toInt()}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              _ProgressBar(value: g.$2 / g.$3, color: g.$5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '+ New goal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.teal,
                    ),
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

class _ProgressBar extends StatelessWidget {
  final double value;
  final Color color;
  final double height;

  const _ProgressBar({
    required this.value,
    required this.color,
    this.height = 7,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        color: Colors.white.withOpacity(0.6),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: value.clamp(0.0, 1.0),
          child: Container(color: color),
        ),
      ),
    );
  }
}