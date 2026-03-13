import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GiftCardsScreen extends StatelessWidget {
  const GiftCardsScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {
      'name': 'بطاقات جوجل بلاي',
      'icon': Icons.android,
      'color': Colors.green,
    },
    {
      'name': 'بطاقات آيتونز',
      'icon': Icons.apple,
      'color': Colors.grey,
    },
    {
      'name': 'بي إن سبورت',
      'icon': Icons.sports_soccer,
      'color': Colors.orange,
    },
    {
      'name': 'بطاقات أمازون',
      'icon': Icons.shopping_cart,
      'color': Colors.amber,
    },
    {
      'name': 'بطاقات إيباي',
      'icon': Icons.shopping_bag,
      'color': Colors.blue,
    },
    {
      'name': 'بطاقات هدايا ميتا',
      'icon': Icons.facebook,
      'color': Colors.indigo,
    },
    {
      'name': 'بلاي ستيشن',
      'icon': Icons.games,
      'color': Colors.blueGrey,
    },
    {
      'name': 'بطاقات ستيم',
      'icon': Icons.computer,
      'color': Colors.cyan,
    },
    {
      'name': 'بطاقات متجر نون',
      'icon': Icons.store,
      'color': Colors.yellow,
    },
    {
      'name': 'اكس بوكس',
      'icon': Icons.videogame_asset,
      'color': Colors.lightGreen,
    },
    {
      'name': 'إليزجولد',
      'icon': Icons.bolt,
      'color': Colors.amber,
    },
    {
      'name': 'بلتزارد',
      'icon': Icons.shield,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('بطائق نت'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final item = _categories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (item['color'] as Color).withOpacity(0.3),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'],
                      color: item['color'],
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
