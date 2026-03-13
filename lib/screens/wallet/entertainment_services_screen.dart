import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class EntertainmentServicesScreen extends StatelessWidget {
  const EntertainmentServicesScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': Colors.purple},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.red},
    {'name': 'تخصيص', 'icon': Icons.palette, 'color': Colors.orange},
    {'name': 'بطائق نت', 'icon': Icons.card_giftcard, 'color': Colors.green},
    {'name': 'تحكم في الشوارع', 'icon': Icons.traffic, 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('خدمات ترفيه'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: (service['color'] as Color).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (service['color'] as Color).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            service['icon'],
                            color: service['color'],
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          service['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
