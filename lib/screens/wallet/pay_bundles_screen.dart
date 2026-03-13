import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PayBundlesScreen extends StatelessWidget {
  const PayBundlesScreen({super.key});

  final List<Map<String, dynamic>> _bundles = const [
    {'name': 'يمكن موبایل باقات - دفع مسبق', 'icon': Icons.wifi, 'color': Colors.green},
    {'name': 'يمكن موبایل باقات - فوتوترة', 'icon': Icons.receipt, 'color': Colors.blue},
    {'name': 'سيافون باقات - دفع مسبق', 'icon': Icons.wifi, 'color': Colors.orange},
    {'name': 'سيافون باقات - فوتوترة', 'icon': Icons.receipt, 'color': Colors.purple},
    {'name': 'You باقات - دفع مسبق', 'icon': Icons.wifi, 'color': Colors.red},
    {'name': 'You باقات - فوتوترة', 'icon': Icons.receipt, 'color': Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('سداد باقات')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _bundles.length,
        itemBuilder: (context, index) {
          final b = _bundles[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (b['color'] as Color).withOpacity(0.2), shape: BoxShape.circle), child: Icon(b['icon'], color: b['color'])),
              title: Text(b['name']),
              trailing: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black), child: const Text('عرض الموقع')),
            ),
          );
        },
      ),
    );
  }
}
