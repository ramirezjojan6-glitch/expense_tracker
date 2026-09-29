import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SummaryCardsRow extends StatefulWidget {
  const SummaryCardsRow({super.key});

  @override
  State<SummaryCardsRow> createState() => _SummaryCardsRowState();
}

class _SummaryCardsRowState extends State<SummaryCardsRow> {
  int _selectedIndex = 0;

  static const _items = [
    ('Balance', '₱8,450', 'AVAILABLE BALANCE', Color.fromARGB(255, 237, 240, 89)),
    ('Income', '₱15,000', 'TOTAL INCOME THIS MONTH', AppColors.cyan),
    ('Expenses', '₱6,550', 'TOTAL EXPENSES THIS MONTH', AppColors.pink),
    ('Remaining', '₱3,450', 'REMAINING THIS MONTH', Color.fromARGB(255, 13, 93, 240)),
  ];

  Color _darken(Color c, double t) => Color.lerp(c, Colors.black, t)!;

  @override
  Widget build(BuildContext context) {
    final selected = _items[_selectedIndex];
    final accent = selected.$4;

    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: AspectRatio(
            aspectRatio: 1.9,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [accent, _darken(accent, 0.4)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 26,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: const LinearGradient(
                            colors: [AppColors.lightPink, AppColors.pink],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.wifi,
                        color: Colors.white.withOpacity(0.85),
                        size: 14,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '•••• •••• •••• 4521',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selected.$3,
                            style: TextStyle(
                              fontSize: 7,
                              letterSpacing: 0.4,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            selected.$2,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'JOJAN RAMIREZ',
                            style: TextStyle(
                              fontSize: 7,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '09/28',
                            style: TextStyle(
                              fontSize: 7,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < _items.length; i++)
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _selectedIndex ? 18 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: i == _selectedIndex ? _items[i].$4 : Colors.black12,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          selected.$1,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.darkTeal,
          ),
        ),
      ],
    );
  }
}