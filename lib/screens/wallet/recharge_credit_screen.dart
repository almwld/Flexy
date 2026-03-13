import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RechargeCreditScreen extends StatelessWidget {
  const RechargeCreditScreen({super.key});

  final List<Map<String, dynamic>> _providers = const [
    {'name': 'يمكن موبايلي', 'icon': Icons.sim_card, 'color': Colors.green},
    {'name': 'سيافون رصيد', 'icon': Icons.phone_android, 'color': Colors.blue},
    {'name': 'سيافون فئات', 'icon': Icons.category, 'color': Colors.orange},
    {'name': 'You', 'icon': Icons.wifi, 'color': Colors.purple},
    {'name': 'والي فوزي', 'icon': Icons.account_balance_wallet, 'color': Colors.red},
    {'name': 'والي رصيد', 'icon': Icons.account_balance_wallet, 'color': Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('شحن الرصيد')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _providers.length,
        itemBuilder: (context, index) {
          final p = _providers[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (p['color'] as Color).withOpacity(0.2), shape: BoxShape.circle), child: Icon(p['icon'], color: p['color'])),
              title: Text(p['name']),
              trailing: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black), child: const Text('عرض')),
            ),
          );
        },
      ),
    );
  }
}
