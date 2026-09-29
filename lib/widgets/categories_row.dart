import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  static const _categories = [
    ('Food', Icons.restaurant_outlined),
    ('Transport', Icons.directions_bus_outlined),
    ('School', Icons.menu_book_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final c in _categories)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(c.$2, color: AppColors.teal, size: 20),
                  const SizedBox(height: 6),
                  Text(
                    c.$1,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.darkTeal,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}