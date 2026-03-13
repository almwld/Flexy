import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark; // ✅ الآن داخل build

    return Scaffold(
      appBar: AppBar(title: const Text('التطبيقات')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('بطاقات الريكي'),
            _buildListItem('لريكي', Icons.card_giftcard, isDark),
            _buildListItem('قنوات تنقلكس', Icons.taxi_alert, isDark),
            const SizedBox(height: 16),
            _buildSectionTitle('أدوبي'),
            _buildListItem('NordVPN', Icons.vpn_lock, isDark),
            _buildListItem('McAfee Antivirus VPN', Icons.security, isDark),
            _buildListItem('كاسبر سكاي', Icons.shield, isDark),
            const SizedBox(height: 16),
            _buildSectionTitle('تفعيلات'),
            _buildListItem('تفعيل ويندوز', Icons.window, isDark),
            _buildListItem('تفعيل الفوفيس', Icons.phonelink_setup, isDark),
            _buildListItem('آتزنت دانولود مانجر', Icons.download, isDark),
            _buildListItem('سيستون غو', Icons.android, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
    );
  }

  Widget _buildListItem(String title, IconData icon, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: isDark ? AppTheme.darkCard : AppTheme.lightCard, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.goldColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
