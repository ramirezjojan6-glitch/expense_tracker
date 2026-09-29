import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  static const _categories = [
    ('Food', Icons.restaurant_outlined),
    ('Transport', Icons.directions_bus_outlined),
    ('School', Icons.menu_book_outlined),
    ('Personal', Icons.person_outline),
    ('Groceries', Icons.local_grocery_store_outlined),
    ('Medical', Icons.local_hospital_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final c = _categories[index];
          return Container(
            width: 72,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          );
        },
      ),
    );
  }
}