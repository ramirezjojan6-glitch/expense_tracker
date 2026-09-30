import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_card.dart';

class CategoriesRow extends StatefulWidget {
  const CategoriesRow({super.key});

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  int? _selectedIndex;

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
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final c = _categories[index];
          final selected = index == _selectedIndex;
          return SizedBox(
            width: 72,
            child: GlassCard(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              borderRadius: 16,
              onTap: () => setState(
                () => _selectedIndex = selected ? null : index,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    c.$2,
                    color: selected ? AppColors.pink : AppColors.teal,
                    size: 20,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.$1,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w400,
                      color: AppColors.darkTeal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}