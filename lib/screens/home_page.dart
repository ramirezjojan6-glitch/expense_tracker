import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/categories_row.dart';
import '../widgets/recent_transactions_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF04342C),
                  ),
                ),
                SizedBox(height: 8),
                CategoriesRow(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: RecentTransactionsCard(),
          ),
        ],
      ),
    );
  }
}