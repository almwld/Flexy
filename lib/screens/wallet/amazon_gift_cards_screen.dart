import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AmazonGiftCardsScreen extends StatelessWidget {
  const AmazonGiftCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('بطاقات أمازون')),
      body: const Center(child: Text('قريباً...')),
    );
  }
}
