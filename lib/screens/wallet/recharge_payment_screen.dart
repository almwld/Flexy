import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RechargePaymentScreen extends StatelessWidget {
  const RechargePaymentScreen({super.key});

  final List<Map<String, dynamic>> _options = const [
    {'name': 'شحن الرصيد', 'icon': Icons.add_card, 'color': Colors.green},
    {'name': 'سداد باقات', 'icon': Icons.wifi, 'color': Colors.blue},
    {'name': 'الانترنت والهاتف الثابت', 'icon': Icons.router, 'color': Colors.orange},
    {'name': 'خدمات يمن فورجي 4G', 'icon': Icons.signal_cellular_4_bar, 'color': Colors.purple},
    {'name': 'فواتير الماء والكهرباء', 'icon': Icons.water_drop, 'color': Colors.cyan},
    {'name': 'التعليم العالي والجامعات', 'icon': Icons.school, 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('الشحن والسداد')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _options.length,
        itemBuilder: (context, index) {
          final opt = _options[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (opt['color'] as Color).withOpacity(0.2), shape: BoxShape.circle), child: Icon(opt['icon'], color: opt['color'])),
              title: Text(opt['name']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
