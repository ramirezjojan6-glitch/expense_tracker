import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_page.dart';
 
void main() {
  runApp(const ExpenseTrackerApp());
}
 
class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpenseTracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
 