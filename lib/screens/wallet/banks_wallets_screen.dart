import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class BanksWalletsScreen extends StatelessWidget {
  const BanksWalletsScreen({super.key});

  final List<String> _banks = const [
    'كاك بنك',
    'كاك الإسلامي',
    'بنك اليمن والكويت',
    'مصرف اليمن والبحرين الشامل',
    'بنك اليمني للارشاد والتعمير',
    'بنك سيا الإسلامي',
  ];

  final List<String> _wallets = const [
    'موبايل موني',
    'كاش',
    'سيأكاش',
    'فلوسك',
    'المتكاملة mPay',
    'جواله',
    'ون كاش',
    'شامل موني',
    'إيزي',
    'يمن واتك',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('بنوك ومحافظ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('بنوك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
            const SizedBox(height: 8),
            ..._banks.map((b) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.account_balance, color: AppTheme.goldColor),
                title: Text(b),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            )),
            const SizedBox(height: 24),
            const Text('محافظ إلكترونية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
            const SizedBox(height: 8),
            ..._wallets.map((w) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: AppTheme.goldColor),
                title: Text(w),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            )),
          ],
        ),
      ),
    );
  }
}
