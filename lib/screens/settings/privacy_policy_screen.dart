import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'سياسة الخصوصية لتطبيق فلكس اليمن',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.goldColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'نحن في فلكس اليمن نلتزم بحماية خصوصية مستخدمينا. توضح هذه السياسة كيفية جمع واستخدام وحماية معلوماتك الشخصية.',
                style: TextStyle(height: 1.6),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('المعلومات التي نجمعها'),
              _buildSectionText(
                '• معلومات الحساب: الاسم، رقم الهاتف، البريد الإلكتروني.\n'
                '• معلومات الاستخدام: سجل التصفح، الإعلانات المفضلة.\n'
                '• معلومات الدفع: لا نخزن بيانات بطاقات الائتمان كاملة.',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('كيف نستخدم معلوماتك'),
              _buildSectionText(
                '• لتقديم وتحسين خدماتنا.\n'
                '• للتواصل معك بشأن تحديثات وعروض.\n'
                '• لضمان أمان المنصة ومنع الاحتيال.',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('مشاركة المعلومات'),
              _buildSectionText(
                'لا نشارك معلوماتك الشخصية مع أطراف ثالثة إلا بموافقتك أو للامتثال للقانون.',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('حماية المعلومات'),
              _buildSectionText(
                'نستخدم إجراءات أمان مشددة لحماية معلوماتك من الوصول غير المصرح به.',
              ),
              const SizedBox(height: 24),
              const Text(
                'آخر تحديث: 15 مارس 2026',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.goldColor,
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: const TextStyle(height: 1.6),
    );
  }
}
