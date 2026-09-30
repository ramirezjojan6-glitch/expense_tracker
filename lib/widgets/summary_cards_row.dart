import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../state/app_state.dart';

class SummaryCardsRow extends StatefulWidget {
  const SummaryCardsRow({super.key});

  @override
  State<SummaryCardsRow> createState() => _SummaryCardsRowState();
}

class _SummaryCardsRowState extends State<SummaryCardsRow> {
  int _selectedIndex = 0;

  Color _darken(Color c, double t) => Color.lerp(c, Colors.black, t)!;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final items = [
          ('Balance', appState.balance, 'AVAILABLE BALANCE', AppColors.darkTeal),
          ('Income', appState.totalIncome, 'TOTAL INCOME THIS MONTH', AppColors.cyan),
          ('Expenses', appState.totalExpenses, 'TOTAL EXPENSES THIS MONTH', AppColors.pink),
          ('Remaining', appState.remaining, 'REMAINING THIS MONTH', AppColors.teal),
        ];
        final selected = items[_selectedIndex];
        final accent = selected.$4;

        return Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: AspectRatio(
                aspectRatio: 1.75,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [accent, _darken(accent, 0.4)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.35),
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
                            width: 30,
                            height: 21,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: const LinearGradient(
                                colors: [AppColors.lightPink, AppColors.pink],
                              ),
                            ),
                          ),
                          Icon(
                            Icons.wifi,
                            color: Colors.white.withValues(alpha: 0.85),
                            size: 16,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '•••• •••• •••• 4521',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.6,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selected.$3,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 8,
                                    letterSpacing: 0.4,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: Text(
                                    '₱${selected.$2.toStringAsFixed(0)}',
                                    key: ValueKey(
                                      '${_selectedIndex}_${selected.$2}',
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'JOJAN RAMIREZ',
                                style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '09/28',
                                style: TextStyle(
                                  fontSize: 7,
                                  color: Colors.white.withValues(alpha: 0.7),
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
                for (var i = 0; i < items.length; i++)
                  GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _selectedIndex ? 18 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: i == _selectedIndex
                            ? items[i].$4
                            : Colors.black12,
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
      },
    );
  }
}