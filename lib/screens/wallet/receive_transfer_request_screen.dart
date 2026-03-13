import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ReceiveTransferRequestScreen extends StatelessWidget {
  const ReceiveTransferRequestScreen({super.key});

  final List<Map<String, dynamic>> _requests = const [
    {'name': 'طلب استلام حوالة محلية', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'طلب استلام حوالة دولية', 'icon': Icons.public, 'color': Colors.blue},
    {'name': 'تقرير طلبات استلام حوالة', 'icon': Icons.report, 'color': Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('طلب استلام حوالة')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final r = _requests[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (r['color'] as Color).withOpacity(0.2), shape: BoxShape.circle), child: Icon(r['icon'], color: r['color'])),
              title: Text(r['name']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
