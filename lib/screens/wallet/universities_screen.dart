import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class UniversitiesScreen extends StatelessWidget {
  const UniversitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('التعليم العالي')),
      body: const Center(child: Text('قريباً...')),
    );
  }
}
