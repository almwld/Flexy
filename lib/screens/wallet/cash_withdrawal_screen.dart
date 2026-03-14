import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CashWithdrawalScreen extends StatelessWidget {
  const CashWithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('سحب نقدي')),
      body: const Center(child: Text('قريباً...')),
    );
  }
}
