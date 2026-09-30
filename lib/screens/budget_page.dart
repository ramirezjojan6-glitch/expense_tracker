import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../state/app_state.dart';
import '../widgets/glass_card.dart';
import '../widgets/dialogs.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  Future<void> _editCategoryLimit(BuildContext context, int index) async {
    final limit = appState.categoryLimits[index];
    final result = await showTextInputDialog(
      context,
      title: 'Edit ${limit.name} limit',
      label: 'Monthly limit',
      initialValue: limit.limit.toStringAsFixed(0),
      keyboardType: TextInputType.number,
    );
    final value = double.tryParse(result ?? '');
    if (value != null && value > 0) {
      appState.updateCategoryLimit(index, value);
    }
  }

  Future<void> _manageGoal(BuildContext context, int index) async {
    final goal = appState.savingsGoals[index];
    final nameController = TextEditingController(text: goal.name);
    final targetController =
        TextEditingController(text: goal.target.toStringAsFixed(0));
    final addController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(goal.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Goal name'),
            ),
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Target amount'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Add funds'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              appState.updateGoal(
                index,
                name: nameController.text.trim(),
                target: double.tryParse(targetController.text.trim()),
              );
              final add = double.tryParse(addController.text.trim());
              if (add != null && add > 0) {
                appState.addFundsToGoal(index, add);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _addGoal(BuildContext context) async {
    final nameController = TextEditingController();
    final targetController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Goal name'),
            ),
            TextField(
              controller: targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Target amount'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final target = double.tryParse(targetController.text.trim());
              if (name.isNotEmpty && target != null && target > 0) {
                appState.addGoal(name: name, target: target);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final spentTotal = appState.totalExpenses;
        final budgetPercent = appState.monthlyBudget == 0
            ? 0.0
            : (spentTotal / appState.monthlyBudget).clamp(0.0, 1.0);

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
                        Text(
                          '${(budgetPercent * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.teal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _ProgressBar(
                      value: budgetPercent,
                      color: AppColors.cyan,
                      height: 10,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₱${spentTotal.toStringAsFixed(0)} of ₱${appState.monthlyBudget.toStringAsFixed(0)} spent · ₱${appState.remaining.toStringAsFixed(0)} left',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
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
                    Text(
                      'Category limits',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    for (var i = 0; i < appState.categoryLimits.length; i++)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => _editCategoryLimit(context, i),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      appState.categoryLimits[i].name,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.darkTeal,
                                      ),
                                    ),
                                    Text(
                                      '₱${appState.spentForCategory(appState.categoryLimits[i].name).toStringAsFixed(0)} / ₱${appState.categoryLimits[i].limit.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                _ProgressBar(
                                  value: appState.categoryLimits[i].limit == 0
                                      ? 0
                                      : appState.spentForCategory(
                                              appState.categoryLimits[i].name) /
                                          appState.categoryLimits[i].limit,
                                  color: appState.categoryLimits[i].color,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Savings goals',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Total saved ₱${appState.savingsGoals.fold(0.0, (s, g) => s + g.saved).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.teal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appState.savingsGoals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final g = appState.savingsGoals[index];
                  return GlassCard(
                    onTap: () => _manageGoal(context, index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: g.color.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(g.icon, size: 18, color: g.color),
                        ),
                        const Spacer(),
                        Text(
                          g.name,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.darkTeal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₱${g.saved.toStringAsFixed(0)} / ₱${g.target.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _ProgressBar(
                          value: g.target == 0 ? 0 : g.saved / g.target,
                          color: g.color,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _addGoal(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.6),
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
              ),
            ],
          ),
        );
      },
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
        color: Colors.white.withValues(alpha: 0.6),
        alignment: Alignment.centerLeft,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (context, animatedValue, child) => FractionallySizedBox(
            widthFactor: animatedValue,
            child: Container(color: color),
          ),
        ),
      ),
    );
  }
}