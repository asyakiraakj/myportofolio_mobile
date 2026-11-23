import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary100 = Color(0xFFE4BEBE);
  static const primary300 = Color(0xFFB96464);
  static const primary500 = Color(0xFF922424);
  static const primary700 = Color(0xFF581616);
  static const primary900 = Color(0xFF1D0707);

  // secondary_100 was provided as RGB, so it is stored as fully opaque ARGB.
  static const secondary100 = Color(0xFFA2C9EC);
  static const secondary300 = Color(0xFF5190C7);
  static const secondary500 = Color(0xFF0056A1);
  static const secondary700 = Color(0xFF003461);
  static const secondary900 = Color(0xFF001120);

  static const background = Color(0xFF0F1027);
  static const text = Color(0xFFD7D8E3);
}
