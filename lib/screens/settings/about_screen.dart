import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('عن التطبيق'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldPrimary, AppTheme.goldLight],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.shopping_bag, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text(
              'FLEX YEMEN',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.goldColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'الإصدار 1.0.0',
              style: TextStyle(color: Colors.grey[500]),
            ),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: 'من نحن',
              content: 'فلكس اليمن هي منصة إلكترونية متكاملة تهدف إلى تسهيل عملية البيع والشراء في اليمن. نحن نقدم منصة آمنة وموثوقة للتجار والعملاء.',
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'مميزاتنا',
              content: '• أمان وموثوقية\n• سرعة في التعامل\n• دعم فني 24/7\n• وسائل دفع متعددة',
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'تواصل معنا',
              content: 'البريد الإلكتروني: support@flexyemen.com\nالهاتف: +967 777 123 456\nالعنوان: صنعاء، اليمن',
            ),
            const SizedBox(height: 32),
            Text(
              '© 2024 FLEX YEMEN. جميع الحقوق محفوظة.',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.goldColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(height: 1.6),
          ),
        ],
      ),
    );
  }
}
