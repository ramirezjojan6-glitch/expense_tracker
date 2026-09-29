import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../widgets/glass_card.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle('Add expense'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 18,
                        color: AppColors.teal,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AUTO',
                              style: TextStyle(
                                fontSize: 8,
                                letterSpacing: 0.5,
                                color: Colors.black45,
                              ),
                            ),
                            Text(
                              'Scan receipt',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.darkTeal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: AppColors.teal,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Amount'),
                const _FieldBox(text: '₱0.00'),
                const SizedBox(height: 14),
                const _FieldLabel('Category'),
                const _FieldBox(
                  text: 'Select category',
                  trailing: Icons.keyboard_arrow_down,
                ),
                const SizedBox(height: 14),
                const _FieldLabel('Date'),
                const _FieldBox(
                  text: 'Sep 28, 2026',
                  trailing: Icons.calendar_today_outlined,
                ),
                const SizedBox(height: 14),
                const _FieldLabel('Note'),
                const _FieldBox(text: 'e.g. Lunch at school', height: 90),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Save expense',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTeal,
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

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.teal,
        ),
      ),
    );
  }
}

class _FieldBox extends StatelessWidget {
  final String text;
  final IconData? trailing;
  final double? height;

  const _FieldBox({required this.text, this.trailing, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment:
            height == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Colors.black45),
            ),
          ),
          if (trailing != null) Icon(trailing, size: 18, color: AppColors.teal),
        ],
      ),
    );
  }
}