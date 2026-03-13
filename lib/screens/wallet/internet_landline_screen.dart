import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class InternetLandlineScreen extends StatelessWidget {
  const InternetLandlineScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'الانترنت', 'icon': Icons.public, 'color': Colors.blue},
    {'name': 'جهات ثابت', 'icon': Icons.phone, 'color': Colors.green},
    {'name': 'الانترنت فايبر FTTH', 'icon': Icons.settings_input_antenna, 'color': Colors.orange},
    {'name': 'يمن واي في', 'icon': Icons.wifi_tethering, 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('الإنترنت والهاتف الثابت')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final s = _services[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (s['color'] as Color).withOpacity(0.2), shape: BoxShape.circle), child: Icon(s['icon'], color: s['color'])),
              title: Text(s['name']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
