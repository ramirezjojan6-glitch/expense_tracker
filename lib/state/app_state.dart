import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TransactionEntry {
  final DateTime date;
  final String description;
  final String category;
  final double amount;
  final bool isIncome;

  TransactionEntry({
    required this.date,
    required this.description,
    required this.category,
    required this.amount,
    required this.isIncome,
  });
}

class SavingsGoal {
  String name;
  double saved;
  double target;
  IconData icon;
  Color color;

  SavingsGoal({
    required this.name,
    required this.saved,
    required this.target,
    required this.icon,
    required this.color,
  });
}

class CategoryLimit {
  String name;
  double limit;
  Color color;

  CategoryLimit({required this.name, required this.limit, required this.color});
}

class AppState extends ChangeNotifier {
  String profileName = 'Jojan';
  String profileRole = 'Student';
  String currency = 'Philippine peso (₱)';
  double monthlyBudget = 10000;
  String appearance = 'Light mode';
  String dataBackup = 'Save to cloud';

  final List<TransactionEntry> transactions = [
    TransactionEntry(
      date: DateTime(2026, 9, 27),
      description: 'Lunch',
      category: 'Food',
      amount: 150,
      isIncome: false,
    ),
    TransactionEntry(
      date: DateTime(2026, 9, 26),
      description: 'Jeepney fare',
      category: 'Transport',
      amount: 80,
      isIncome: false,
    ),
    TransactionEntry(
      date: DateTime(2026, 9, 25),
      description: 'School supplies',
      category: 'School',
      amount: 350,
      isIncome: false,
    ),
    TransactionEntry(
      date: DateTime(2026, 9, 24),
      description: 'Allowance',
      category: 'Income',
      amount: 2000,
      isIncome: true,
    ),
    TransactionEntry(
      date: DateTime(2026, 9, 22),
      description: 'Groceries',
      category: 'Food',
      amount: 420,
      isIncome: false,
    ),
    TransactionEntry(
      date: DateTime(2026, 9, 20),
      description: 'Internet load',
      category: 'Bills',
      amount: 299,
      isIncome: false,
    ),
    TransactionEntry(
      date: DateTime(2026, 9, 18),
      description: 'Part-time job',
      category: 'Income',
      amount: 1500,
      isIncome: true,
    ),
    TransactionEntry(
      date: DateTime(2026, 9, 16),
      description: 'Book purchase',
      category: 'School',
      amount: 450,
      isIncome: false,
    ),
  ];

  final List<CategoryLimit> categoryLimits = [
    CategoryLimit(name: 'Food', limit: 3000, color: AppColors.cyan),
    CategoryLimit(name: 'Transport', limit: 2000, color: AppColors.teal),
    CategoryLimit(name: 'School', limit: 1500, color: AppColors.pink),
    CategoryLimit(name: 'Bills', limit: 1000, color: AppColors.darkTeal),
  ];

  final List<SavingsGoal> savingsGoals = [
    SavingsGoal(
      name: 'New laptop',
      saved: 5000,
      target: 15000,
      icon: Icons.laptop_mac,
      color: AppColors.cyan,
    ),
    SavingsGoal(
      name: 'Emergency fund',
      saved: 3650,
      target: 5000,
      icon: Icons.health_and_safety_outlined,
      color: AppColors.teal,
    ),
    SavingsGoal(
      name: 'Baguio trip',
      saved: 500,
      target: 4000,
      icon: Icons.flight_takeoff,
      color: AppColors.pink,
    ),
  ];

  double get totalIncome =>
      transactions.where((t) => t.isIncome).fold(0.0, (s, t) => s + t.amount);

  double get totalExpenses =>
      transactions.where((t) => !t.isIncome).fold(0.0, (s, t) => s + t.amount);

  double get balance => totalIncome - totalExpenses;

  double get remaining => monthlyBudget - totalExpenses;

  double spentForCategory(String category) => transactions
      .where((t) => !t.isIncome && t.category == category)
      .fold(0.0, (s, t) => s + t.amount);

  List<TransactionEntry> get sortedTransactions {
    final list = [...transactions];
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  void addExpense({
    required String description,
    required String category,
    required double amount,
    required DateTime date,
  }) {
    transactions.insert(
      0,
      TransactionEntry(
        date: date,
        description: description.isEmpty ? category : description,
        category: category,
        amount: amount,
        isIncome: false,
      ),
    );
    notifyListeners();
  }

  void addFundsToGoal(int index, double amount) {
    final g = savingsGoals[index];
    g.saved = (g.saved + amount).clamp(0, g.target);
    notifyListeners();
  }

  void updateGoal(int index, {String? name, double? target}) {
    final g = savingsGoals[index];
    if (name != null && name.isNotEmpty) g.name = name;
    if (target != null && target > 0) g.target = target;
    notifyListeners();
  }

  void addGoal({required String name, required double target}) {
    const colors = [
      AppColors.cyan,
      AppColors.teal,
      AppColors.pink,
      AppColors.darkTeal,
    ];
    savingsGoals.add(
      SavingsGoal(
        name: name,
        saved: 0,
        target: target,
        icon: Icons.flag_outlined,
        color: colors[savingsGoals.length % colors.length],
      ),
    );
    notifyListeners();
  }

  void updateCategoryLimit(int index, double newLimit) {
    categoryLimits[index].limit = newLimit;
    notifyListeners();
  }

  void updateProfile({String? name, String? role}) {
    if (name != null && name.isNotEmpty) profileName = name;
    if (role != null && role.isNotEmpty) profileRole = role;
    notifyListeners();
  }

  void updateCurrency(String v) {
    currency = v;
    notifyListeners();
  }

  void updateMonthlyBudget(double v) {
    monthlyBudget = v;
    notifyListeners();
  }

  void updateAppearance(String v) {
    appearance = v;
    notifyListeners();
  }

  void updateDataBackup(String v) {
    dataBackup = v;
    notifyListeners();
  }
}

final appState = AppState();