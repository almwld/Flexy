import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('FLEX', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, letterSpacing: 2, fontFamily: 'Changa')),
            const SizedBox(width: 4),
            const Text('YEMEN', style: TextStyle(fontSize: 14, color: AppTheme.goldLight, fontFamily: 'Changa')),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          ],
        ),
      ),
      body: const Center(
        child: Text('شاشة الخريطة - قيد التطوير', style: TextStyle(fontFamily: 'Changa')),
      ),
    );
  }
}
