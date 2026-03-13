import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  final List<String> _games = const [
    'بيجي',
    'العالمية',
    'بيجي الريت',
    'العالمية',
    'يكوبي العالمني',
    'العالمية',
    'اكواد فير فاير',
    '+ فير فاير',
    'بيجي نيو ستيت',
    'FC MOBILE',
    'كول أوف ديوتي',
    'XBOX Mobile',
    'مافيا سيقي',
    'دلتا فورس غارينا',
    'أونمويجي آرينا',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الألعاب'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _games.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                child: const Icon(Icons.sports_esports, color: AppTheme.goldColor),
              ),
              title: Text(_games[index]),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
