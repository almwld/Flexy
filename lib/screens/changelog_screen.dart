import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class ChangelogScreen extends StatelessWidget {
  const ChangelogScreen({super.key});

  final List<Map<String, dynamic>> _versions = const [
    {
      'version': '2.0.0',
      'date': '15 مارس 2026',
      'type': 'major',
      'features': [
        'إعادة تصميم كامل للواجهة',
        'إضافة المحفظة الإلكترونية (3 عملات)',
        'نظام المحادثات الفوري',
        'إمكانية رفع الصور في الإعلانات',
        'تحسين الأداء والثبات',
      ],
    },
    {
      'version': '1.5.0',
      'date': '1 فبراير 2026',
      'type': 'minor',
      'features': [
        'إضافة صفحة العروض والتخفيضات',
        'تحسين شاشة البحث مع فلاتر متقدمة',
        'إمكانية مشاركة الإعلان',
      ],
    },
    {
      'version': '1.2.0',
      'date': '10 يناير 2026',
      'type': 'minor',
      'features': [
        'إضافة الإشعارات الفورية',
        'دعم الدخول كضيف',
        'تحسين أداء السلايدر',
      ],
    },
    {
      'version': '1.0.0',
      'date': '20 ديسمبر 2025',
      'type': 'major',
      'features': [
        'الإطلاق الرسمي للتطبيق',
        'تصفح الإعلانات',
        'تسجيل الدخول وإنشاء حساب',
        'إضافة إعلانات جديدة',
        'الوضع الليلي/النهاري',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الإصدارات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // الإصدار الحالي
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.goldColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'الإصدار الحالي',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '2.0.0',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'تم التحديث: 15 مارس 2026',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().scale(),

            const SizedBox(height: 24),

            // قائمة الإصدارات السابقة
            ...List.generate(_versions.length, (index) {
              final version = _versions[index];
              final isMajor = version['type'] == 'major';
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isMajor ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
                    width: isMajor ? 2 : 1,
                  ),
                ),
                child: ExpansionTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isMajor
                          ? AppTheme.goldColor.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isMajor ? Icons.star : Icons.update,
                      color: isMajor ? AppTheme.goldColor : Colors.grey,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        'الإصدار ${version['version']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isMajor
                              ? AppTheme.goldColor.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isMajor ? 'تحديث رئيسي' : 'تحديث فرعي',
                          style: TextStyle(
                            color: isMajor ? AppTheme.goldColor : Colors.blue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(version['date']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: version['features'].map<Widget>((feature) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 18,
                                  color: isMajor ? AppTheme.goldColor : Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(feature),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.2, end: 0);
            }),
          ],
        ),
      ),
    );
  }
}
