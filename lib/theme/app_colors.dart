import 'package:flutter/material.dart';

class AppColors {
  static const darkTeal = Color(0xFF00312E);
  static const teal = Color(0xFF066255);
  static const cyan = Color(0xFF039F9B);
  static const pink = Color(0xFFE090AD);
  static const lightPink = Color(0xFFFAD3D8);
  static final softCyan = Color.lerp(cyan, Colors.white, 0.55)!;
  static final softPink = Color.lerp(pink, Colors.white, 0.45)!;
}