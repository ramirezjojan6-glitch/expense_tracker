import 'package:flutter/material.dart';

/// Empty stand-in for screens that haven't been built yet
/// (Transactions, Add expense, Budget, Savings, Settings).
class PlaceholderPage extends StatelessWidget {
  final String label;

  const PlaceholderPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}