import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GovernmentPaymentsScreen extends StatelessWidget {
  const GovernmentPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('مدفوعات حكومية')),
      body: const Center(child: Text('قريباً...')),
    );
  }
}
