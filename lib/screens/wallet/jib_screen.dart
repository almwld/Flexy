import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class JibScreen extends StatelessWidget {
  const JibScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('جيب')),
      body: const Center(child: Text('قريباً...')),
    );
  }
}
