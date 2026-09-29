import 'package:flutter/material.dart';
import '../theme/page_title.dart';

class PlaceholderPage extends StatelessWidget {
  final String label;

  const PlaceholderPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: PageTitle(label),
    );
  }
}