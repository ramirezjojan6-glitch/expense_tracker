import 'package:flutter/material.dart';
import '../widgets/greeting.dart';
import '../widgets/summary_cards_row.dart';
import '../widgets/spending_overview_card.dart';
import '../widgets/recent_transactions_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseTracker'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Greeting(),
            SizedBox(height: 16),
            SummaryCardsRow(),
            SizedBox(height: 16),
            SpendingOverviewCard(),
            SizedBox(height: 16),
            RecentTransactionsCard(),
          ],
        ),
      ),
    );
  }
}