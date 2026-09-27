import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final String label;

  const PlaceholderPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}